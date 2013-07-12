== Bootsrap ==

Иметь установленный и работающий PostgreSQL 8.4 или старше.

brew install sphinx
brew install imagemagick
bundle install
rake db:create

== Rake-таски ==

rake db:import - импорт БД с боевого сайта (younglovers.ru) в локальную БД для разработки (development)
rake static    - импорт всех картинок с боевого сайта (younglovers.ru)

== Deploy ==

cap deploy            - деплой из Гита на стейджинг для тестирования test.younglovers.ru
cap production deploy - деплой из Гита на боевой сайт younglovers.ru
