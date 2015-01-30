#!/bin/bash
cd /var/www/younglovers
bundle exec unicorn -c config/unicorn/production.rb -E production -D nginx