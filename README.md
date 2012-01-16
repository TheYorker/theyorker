The Yorker Website
==================

Server Configuration
--------------------

This is correct for Debian 6.0 as of 07/01/12

```bash
# too many servers don't install any locales,
# so let's supress all those nasty error messages
apt-get install locales
dpkg-reconfigure locales

# install requirements for rvm
apt-get install curl git-core

# install rvm
bash -s stable < <(curl -s https://raw.github.com/wayneeseguin/rvm/master/binscripts/rvm-installer )

# exit & relogin to pick up rvm

# install rvm ruby dependencies
apt-get install build-essential openssl libreadline6 libreadline6-dev curl git-core zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-0 libsqlite3-dev sqlite3 libxml2-dev libxslt-dev autoconf libc6-dev ncurses-dev automake libtool bison subversion

# install ruby
rvm install ruby-1.9.2
rvm use ruby-1.9.2 --default

# install passenger
gem install passenger

# install nginx
passenger-install-nginx-module


# install postgres
apt-get install postgresql libpq-dev

```

Installation
------------


---

David Morris, 2011

