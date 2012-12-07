sudo apt-get install -y curl build-essential openssl libreadline6 libreadline6-dev curl libcurl4-openssl-dev git-core zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt-dev autoconf libc6-dev ncurses-dev automake libtool bison subversion pkg-config

curl -L https://get.rvm.io | bash -s stable
rvm reload
rvm get head
rvm install 1.9.3 -n perf --patch falcon
rvm alias create default 1.9.3-p327-perf
# rvm use 1.9.3-perf --default
# rvm use 1.9.3-p327-perf@global
rvm gemset use global

gem install bundle

rvm reload


sudo apt-add-repository -y ppa:pitti/postgresql
sudo apt-get -y update
sudo apt-get -y install postgresql-9.2 libpq-dev


gem install passenger
rvmsudo passenger-install-nginx-module

git clone git://github.com/vkurennov/rails-nginx-passenger-ubuntu.git

sudo mv rails-nginx-passenger-ubuntu/nginx/nginx /etc/init.d/nginx
sudo chown root:root /etc/init.d/nginx

sudo /etc/init.d/nginx restart










# Виталий: ну я обычно делаю так:
# на серваке ставлю gem passenger
# затем запускаю rvmsudo passenger-install-nginx-module
# этот модуль сам качает и устанаваливает nginx с нужными настройками

# Дмитрий: да, но ruby у моего root нет вообще

# Виталий: а причем здесть root и ruby?
# passenger установит и скомпилит nginx, но пропишет путь к руби и к себе самому для твоего юзера
# т.е. по тому пути, куда rvm установил руби
# правда, надо еще добавить на сервак скрипт для запуска/перезапуска nginx
# для этого надо на сервак склонировать вот этот проект:
# git://github.com/vkurennov/rails-nginx-passenger-ubuntu.git
# и дальше сделать:
# sudo mv rails-nginx-passenger-ubuntu/nginx/nginx /etc/init.d/nginx
# sudo chown root:root /etc/init.d/nginx
# после этого ты сможешь запускать, останавливать или перезапускать nginx так:
# sudo /etc/init.d/nginx restart
# ну или start/stop
# и мой тебе совет - не надо это делать через рецепты капистрано, проще и быстрее сделать все на сервере
# и по-моему, правильнее

# Дмитрий: я правильно понимаю : при описаном тобой раскладе rvm будет установлен только у пользователя, а вэб сервер будет работать с правами рута ?

# Виталий: не совсем, nginx будет установлен от рута, что и должно быть, но настроен он будет на использование руби и passenger из-под твоего пользоывателя

# Дмитрий: аа
# буду пробовать
# скасибо за инструкцию:)

# Виталий: ты всю инструкцию получил? :-)
# а то у меня писалось, что ты отключался

