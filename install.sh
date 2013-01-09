sudo apt-get install -y curl build-essential openssl libreadline6 libreadline6-dev curl libcurl4-openssl-dev git-core zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt-dev autoconf libc6-dev ncurses-dev automake libtool bison subversion pkg-config

curl -L https://get.rvm.io | bash -s stable
rvm reload
rvm get head
rvm install 1.9.3
rvm gemset use global

gem install bundle
rvm reload

#install postgres
sudo apt-get -y install software-properties-common python-software-properties
sudo apt-add-repository -y ppa:pitti/postgresql
sudo apt-get -y update
sudo apt-get -y install postgresql-9.2 postgresql-contrib-9.2 libpq-dev 


gem install passenger
rvmsudo passenger-install-nginx-module

git clone git://github.com/vkurennov/rails-nginx-passenger-ubuntu.git
# git clone git@github.com:ovcharenkodi/rails-nginx-passenger-ubuntu.git
sudo mv rails-nginx-passenger-ubuntu/nginx/nginx /etc/init.d/nginx
sudo chown root:root /etc/init.d/nginx
sudo /etc/init.d/nginx restart
