FROM ubuntu:14.04

RUN apt-get update -q
RUN apt-get install -qy curl git python-software-properties software-properties-common postgresql-9.3 postgresql-client-9.3 postgresql-contrib-9.3 libpq-dev git-core zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libxml2-dev libxslt1-dev nodejs nginx

USER postgres

# Create a PostgreSQL role named ``docker`` with ``docker`` as the password and
# then create a database `docker` owned by the ``docker`` role.
# Note: here we use ``&&\`` to run commands one after the other - the ``\``
#       allows the RUN command to span multiple lines.
RUN    /etc/init.d/postgresql start &&\
    psql --command "CREATE USER docker WITH SUPERUSER PASSWORD 'docker';" &&\
    createdb -O docker docker

# Adjust PostgreSQL configuration so that remote connections to the
# database are possible. 
RUN echo "host all  all    0.0.0.0/0  md5" >> /etc/postgresql/9.3/main/pg_hba.conf

# And add ``listen_addresses`` to ``/etc/postgresql/9.3/main/postgresql.conf``
RUN echo "listen_addresses='*'" >> /etc/postgresql/9.3/main/postgresql.conf

# Expose the PostgreSQL port
EXPOSE 5432

# Add VOLUMEs to allow backup of config, logs and databases
VOLUME  ["/etc/postgresql", "/var/log/postgresql", "/var/lib/postgresql"]

# Set the default command to run when starting the container
CMD ["/usr/lib/postgresql/9.3/bin/postgres", "-D", "/var/lib/postgresql/9.3/main", "-c", "config_file=/etc/postgresql/9.3/main/postgresql.conf"]

RUN curl -L get.rvm.io | bash -s stable
RUN source ~/.rvm/scripts/rvm
RUN rvm requirements
RUN rvm install 2.1.2
RUN rvm use 2.1.2 --default
RUN rvm rubygems current
RUN echo "daemon off;" >> /etc/nginx/nginx.conf
RUN rm /etc/nginx/sites-enabled/default
RUN mkdir -p /var/www
RUN /bin/bash -l -c "gem install bundler --no-ri --no-rdoc"

WORKDIR /tmp
ADD Gemfile Gemfile
ADD Gemfile.lock Gemfile.lock
RUN /bin/bash -l -c "bundle install"

ADD ./ /var/www/younglovers
ADD config/younglovers.conf /etc/nginx/sites-enabled/younglovers
ADD config/start_server.sh /usr/bin/start_server
RUN chmod -x /usr/bin/start_server
RUN mkdir -p /var/www/younglovers/tmp/pids
RUN mkdir -p /var/www/younglovers/tmp/sockets
RUN mkdir -p /var/www/younglovers/tmp/log

WORKDIR /var/www/younglovers/

EXPOSE 80

ENTRYPOINT /usr/bin/start_server
