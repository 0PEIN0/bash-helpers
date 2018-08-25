#!/bin/bash

installPhp() {
  funcName=$(getFunctionName)
  checkIfSudo $funcName
  if [ "${?}" = "0" ] ; then
    return
  fi;
  aptGet
  cd $SYSTEM_SOFTWARE_FOLDER/
  printf 'y\n' | sudo apt-get install apache2
  aptGet
  printf 'y\n' | sudo apt-get install apache2 php7.0 libapache2-mod-php7.0
  aptGet
  curl -sS https://getcomposer.org/installer | php
  sudo mv composer.phar /usr/local/bin/composer
  aptGet
  sudo phpenmod mcrypt
  sudo phpenmod mbstring
  sudo a2enmod rewrite
  sudo systemctl restart apache2
  goToRoot
}

installLaravelNonSudo() {
  funcName=$(getFunctionName)
  checkIfNotSudo $funcName
  if [ "${?}" = "0" ] ; then
    return
  fi;
  goToRoot
  composer global require "laravel/installer"
  echo 'export PATH="$PATH:$HOME/.composer/vendor/bin"' >> ~/.bash_aliases
  eval "bash_refresh"
  #http://vaguelyuseful.info/2016/08/03/installing-laravel-5-2-on-ubuntu-16-04-and-apache2/
  goToRoot
}

installPhpmyadmin() {
  funcName=$(getFunctionName)
  checkIfSudo $funcName
  if [ "${?}" = "0" ] ; then
    return
  fi;
  goToRoot
  printf 'y\n' | sudo apt-get install mysql-server
  sudo mysql_secure_installation
  sudo apt-get install phpmyadmin php-mbstring php-gettext
  #https://www.digitalocean.com/community/tutorials/how-to-install-and-secure-phpmyadmin-on-ubuntu-16-04
  goToRoot
}

installPhpFive() {
  funcName=$(getFunctionName)
  checkIfSudo $funcName
  if [ "${?}" = "0" ] ; then
    return
  fi;
  goToRoot
  printf '\n' | sudo add-apt-repository ppa:ondrej/php
  aptGet
  printf 'y\n' | sudo apt-get install -y php5.6
  goToRoot
}

alias apache_restart='/etc/init.d/apache2 restart'
alias get_apache_users='ps -ef | grep apache | grep -v grep'
alias install_laravel=installLaravelNonSudo
alias install_php=installPhp
alias install_php_five=installPhpFive
alias install_php_my_admin=installPhpmyadmin
