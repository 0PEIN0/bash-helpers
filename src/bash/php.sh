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
  printf 'y\n' | sudo apt-get install php5.6-mysql
  printf 'y\n' | sudo apt-get install php5.6-mbstring
  goToRoot
}

installPhpSeven() {
  funcName=$(getFunctionName)
  checkIfSudo $funcName
  if [ "${?}" = "0" ] ; then
    return
  fi;
  goToRoot
  printf '\n' | sudo add-apt-repository ppa:ondrej/php
  aptGet
  printf 'y\n' | sudo apt-get install -y php7.2
  printf 'y\n' | sudo apt-get install php7.2-mysql
  printf 'y\n' | sudo apt-get install php7.2-mbstring
  goToRoot
}

phpSwitchSevenToFive() {
  funcName=$(getFunctionName)
  checkIfSudo $funcName
  if [ "${?}" = "0" ] ; then
    return
  fi;
  goToRoot
  sudo a2dismod php7.0
  sudo a2dismod php7.2
  sudo a2enmod php5.6
  eval "apache_restart"
  sudo update-alternatives --set php /usr/bin/php5.6
  # sample output for above command: update-alternatives: using /usr/bin/php5.6 to provide /usr/bin/php (php) in manual mode
  sudo update-alternatives --set phpize /usr/bin/phpize5.6
  sudo update-alternatives --set php-config /usr/bin/php-config5.6
  eval "apache_restart"
  goToRoot
}

phpSwitchFiveToSeven() {
  funcName=$(getFunctionName)
  checkIfSudo $funcName
  if [ "${?}" = "0" ] ; then
    return
  fi;
  goToRoot
  sudo a2dismod php5.6
  sudo a2enmod php7.2
  eval "apache_restart"
  sudo update-alternatives --set php /usr/bin/php7.2
  sudo update-alternatives --set phpize /usr/bin/phpize7.2
  sudo update-alternatives --set php-config /usr/bin/php-config7.2
  eval "apache_restart"
  goToRoot
}

installPhpCsFixer() {
  funcName=$(getFunctionName)
  checkIfSudo $funcName
  if [ "${?}" = "0" ] ; then
    return
  fi;
  goToRoot
  cd $SYSTEM_SOFTWARE_FOLDER
  wget https://cs.sensiolabs.org/download/php-cs-fixer-v2.phar -O php-cs-fixer
  sudo chmod a+x php-cs-fixer
  sudo mv php-cs-fixer /usr/local/bin/php-cs-fixer
  goToRoot
}

updatePhpCsFixer() {
  funcName=$(getFunctionName)
  checkIfSudo $funcName
  if [ "${?}" = "0" ] ; then
    return
  fi;
  goToRoot
  cd $SYSTEM_SOFTWARE_FOLDER
  php /usr/local/bin/php-cs-fixer self-update
  goToRoot
}

alias apache_restart='/etc/init.d/apache2 restart'
alias get_apache_users='ps -ef | grep apache | grep -v grep'
alias install_laravel=installLaravelNonSudo
alias install_php=installPhp
alias install_php_cs_fixer=installPhpCsFixer
alias install_php_five=installPhpFive
alias install_php_my_admin=installPhpmyadmin
alias install_php_seven=installPhpSeven
alias php_switch_from_five_to_seven=phpSwitchFiveToSeven
alias php_switch_from_seven_to_five=phpSwitchSevenToFive
alias update_php_cs_fixer=updatePhpCsFixer
