#!/bin/bash

installPythonAndPostgres() {
  funcName=$(getFunctionName)
  checkIfSudo $funcName
  if [ "${?}" = "0" ] ; then
    return
  fi;
  goToRoot
  aptGet
  printf 'y\n' | sudo apt-get install python-software-properties python-pip python-dev python3-dev libpq-dev postgresql postgresql-contrib pgadmin3 libxml2-dev libxslt1-dev libjpeg-dev python-gpgme
  printf 'y\n' | sudo apt-get install python-lxml python-cffi libcairo2 libpango1.0-0 libgdk-pixbuf2.0-0 shared-mime-info libxslt-dev libffi-dev libcairo2-dev libpango1.0-dev libreadline-gplv2-dev libncursesw5-dev libssl-dev libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev
  printf 'y\n' | sudo apt-get install python-pyaudio python-numpy
  printf 'y\n' | sudo apt-get install postgresql-server-dev-9.5
  printf 'y\n' | sudo apt-get install python-scipy
  #geo-spatial packages
  printf 'y\n' | sudo apt-get install binutils libproj-dev gdal-bin libgdal-dev postgis
  cd $SYSTEM_SOFTWARE_FOLDER
  sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -sc)-pgdg main" >> /etc/apt/sources.list'
  wget --quiet -O - http://apt.postgresql.org/pub/repos/apt/ACCC4CF8.asc | sudo apt-key add -
  aptGet
  sudo apt-get install -y postgresql-9.6
  sudo apt-get install -y postgresql-9.6-postgis-2.3-scripts
  sudo apt-get install -y postgresql-contrib-9.6
  aptGet
  printf "y\n" | sudo apt autoremove
  aptGet
  wget -O $LATEST_POSTGIS_VERSION.tar.gz http://postgis.net/stuff/$LATEST_POSTGIS_VERSION.tar.gz
  tar xvfz $LATEST_POSTGIS_VERSION.tar.gz
  cd $LATEST_POSTGIS_VERSION
  ./configure
  make
  make install
  cd ..
  rm -rf $LATEST_POSTGIS_VERSION.tar.gz
  rm -rf $LATEST_POSTGIS_VERSION
  goToRoot
  pip install --upgrade requests
  pip install --upgrade WeasyPrint
  pip install --upgrade pip
  pip install --upgrade apiai
  pip install --upgrade django
  pip install --upgrade virtualenv
  pip install --upgrade jsbeautifier
  pip install --upgrade autopep8
  pip install --upgrade isort
  pip install --upgrade coursera-dl
  pip install --upgrade setuptools
  pip install --upgrade html5lib
  pip install --upgrade awscli
  pip install --upgrade pyOpenSSL==16.2.0
  pip install --upgrade selenium
  pip install --upgrade python-language-server
  pip install --upgrade jupyter
  pip install --upgrade leo
  pip install --upgrade pandas
  pip install --upgrade quandl
  pip install --upgrade sklearn
  pip install --upgrade numpy
  pip install --upgrade scipy
  sudo service postgresql restart
  #the following command is for postgis installation in postgres in 9.3
  #sudo apt-get install postgresql-9.3-postgis-scripts postgresql-9.3-postgis-2.1-scripts
}

installGeos() {
  funcName=$(getFunctionName)
  checkIfSudo $funcName
  if [ "${?}" = "0" ] ; then
    return
  fi;
  goToRoot
  cd $SYSTEM_SOFTWARE_FOLDER
  cd $softwareFolder/
  wget -O $LATEST_GEOS_VERSION.tar.bz2 http://download.osgeo.org/geos/$LATEST_GEOS_VERSION.tar.bz2
  tar xjf $LATEST_GEOS_VERSION.tar.bz2
  cd $LATEST_GEOS_VERSION
  ./configure
  make
  printf 'y\n' | make install
  cd ..
  rm -rf $LATEST_GEOS_VERSION
  rm -rf $LATEST_GEOS_VERSION.tar.bz2
  goToRoot
}

installHackLang() {
  funcName=$(getFunctionName)
  checkIfSudo $funcName
  if [ "${?}" = "0" ] ; then
    return
  fi;
  goToRoot
  sudo apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0x5a16e7281be7a449
  printf '\n' | sudo add-apt-repository "deb http://dl.hhvm.com/ubuntu $(lsb_release -sc) main"
  aptGet
  printf 'y\n' | sudo apt-get install hhvm
}

installPython() {
  funcName=$(getFunctionName)
  checkIfSudo $funcName
  if [ "${?}" = "0" ] ; then
    return
  fi;
  #latest python version
  mkdir -p /opt/python3.6
  cd /opt/python3.6
  wget -O Python-$LATEST_PYTHON_VERSION.tgz --no-check-certificate https://www.python.org/ftp/python/$LATEST_PYTHON_VERSION/Python-$LATEST_PYTHON_VERSION.tgz
  sudo tar xzf Python-$LATEST_PYTHON_VERSION.tgz
  cd Python-$LATEST_PYTHON_VERSION
  sudo ./configure
  sudo make altinstall
  python3.6 -V
}

installHipchat() {
  funcName=$(getFunctionName)
  checkIfSudo $funcName
  if [ "${?}" = "0" ] ; then
    return
  fi;
  goToRoot
  aptGet
  # Dependent on ubuntu version
  sudo sh -c 'echo "deb https://atlassian.artifactoryonline.com/atlassian/hipchat-apt-client $(lsb_release -c -s) main" > /etc/apt/sources.list.d/atlassian-hipchat4.list'
  wget -O - https://atlassian.artifactoryonline.com/atlassian/api/gpg/key/public | sudo apt-key add -
  aptGet
  printf 'y\n' | sudo apt-get install hipchat4
}

installBracket() {
  funcName=$(getFunctionName)
  checkIfSudo $funcName
  if [ "${?}" = "0" ] ; then
    return
  fi;
  if [ -z "$1" ]; then
    echo "null value not allowed as first parameter for method: \"${funcName}\"! You must pass the required parameter(s)."
    return $1
  fi;
  goToRoot
  aptGet
  cd $SYSTEM_SOFTWARE_FOLDER
  printf '\n' | sudo add-apt-repository ppa:webupd8team/brackets
  aptGet
  printf 'y\n' | sudo apt-get install brackets
  #wget -O Brackets.Release.$1.64-bit.deb --no-check-certificate https://github.com/adobe/brackets/releases/download/release-$1/Brackets.Release.$1.64-bit.deb
  #printf 'y\n' | sudo apt install $SYSTEM_SOFTWARE_FOLDER/Brackets.Release.$1.64-bit.deb
  #sudo dpkg -i $SYSTEM_SOFTWARE_FOLDER/Brackets.Release.$1.64-bit
  #printf 'y\n' | sudo apt-get install -f
  goToRoot
}

installBlender() {
  funcName=$(getFunctionName)
  checkIfSudo $funcName
  if [ "${?}" = "0" ] ; then
    return
  fi;
  goToRoot
  aptGet
  printf '\n' | sudo add-apt-repository ppa:thomas-schiex/blender
  aptGet
  printf 'y\n' | sudo apt install blender
  goToRoot
}

installVisualStudioCode() {
  funcName=$(getFunctionName)
  checkIfSudo $funcName
  if [ "${?}" = "0" ] ; then
    return
  fi;
  if [ -z "$1" ]; then
    echo "null value not allowed as first parameter for method: \"${funcName}\"! You must pass the required parameter(s)."
    return $1
  fi;
  goToRoot
  aptGet
  cd $SYSTEM_SOFTWARE_FOLDER
  printf 'y\n' | sudo apt-get install gvfs-bin
  wget -O $1 --no-check-certificate "https://go.microsoft.com/fwlink/?LinkID=760868"
  #wget -O code_1.3.1-1468329898_amd64.deb --no-check-certificate https://az764295.vo.msecnd.net/stable/e6b4afa53e9c0f54edef1673de9001e9f0f547ae/code_1.3.1-1468329898_amd64.deb
  sudo dpkg -i $1
  rm -rf $1
  goToRoot
}

installVSCodeExtensionsNonSudo() {
  funcName=$(getFunctionName)
  checkIfNotSudo $funcName
  if [ "${?}" = "0" ] ; then
    return
  fi;
  code --install-extension ms-vscode.cpptools
  code --install-extension ms-vscode.csharp
  code --install-extension robertohuertasm.vscode-icons
  code --install-extension PeterJausovec.vscode-docker
  code --install-extension Shan.code-settings-sync
  code --install-extension donjayamanne.githistory
  code --install-extension donjayamanne.python
  code --install-extension hnw.vscode-auto-open-markdown-preview
  code --install-extension nwallace.peep
  code --install-extension streetsidesoftware.code-spell-checker
  code --install-extension waderyan.gitblame
  code --install-extension msjsdiag.debugger-for-chrome
  code --install-extension HookyQR.beautify
  code --install-extension dbaeumer.vscode-eslint
  code --install-extension lukehoban.Go
  code --install-extension abusaidm.html-snippets
  code --install-extension ms-vscode.PowerShell
  code --install-extension eg2.tslint
  code --install-extension johnpapa.Angular2
  code --install-extension zhuangtongfa.Material-theme
  code --install-extension xabikos.JavaScriptSnippets
  code --install-extension formulahendry.code-runner
  code --install-extension redhat.java
  code --install-extension felixfbecker.php-debug
  code --install-extension magicstack.MagicPython
  code --install-extension Shan.code-settings-sync
  code --install-extension Zignd.html-css-class-completion
}

installDotNetCore() {
  funcName=$(getFunctionName)
  checkIfSudo $funcName
  if [ "${?}" = "0" ] ; then
    return
  fi;
  goToRoot
  #Reference: https://www.microsoft.com/net/core#linuxubuntu
  # Dependent on ubuntu version
  curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
  sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
  sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/microsoft-ubuntu-\"$(lsb_release -sc)\"-prod \"$(lsb_release -sc)\" main" > /etc/apt/sources.list.d/dotnetdev.list'
  aptGet
  printf 'y\n' | sudo apt-get install dotnet-sdk-2.0.0
  goToRoot
}

installMongoDb() {
  funcName=$(getFunctionName)
  checkIfSudo $funcName
  if [ "${?}" = "0" ] ; then
    return
  fi;
  goToRoot
  sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2930ADAE8CAF5059EE73BB4B58712A2291FA4AD5
  # Dependent on ubuntu version
  echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu "$(lsb_release -sc)"/mongodb-org/3.6 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.6.list
  aptGet
  printf 'y\n' | sudo apt-get install --allow-unauthenticated -y mongodb-org
  sudo service mongod start
  goToRoot
}

powerlineFontInstallationSudo() {
  funcName=$(getFunctionName)
  checkIfSudo $funcName
  if [ "${?}" = "0" ] ; then
    return
  fi;
  goToRoot
  aptGet
  cd $SYSTEM_SOFTWARE_FOLDER
  wget -O master.zip --no-check-certificate https://github.com/powerline/fonts/archive/master.zip
  unzip master.zip
  sh fonts-master/install.sh
  rm -rf master.zip
  rm -rf fonts-master
  fc-cache -f -v
  goToRoot
}

powerlineFontInstallationNonSudo() {
  funcName=$(getFunctionName)
  checkIfNotSudo $funcName
  if [ "${?}" = "0" ] ; then
    return
  fi;
  goToRoot
  checkSoftwareFolder
  wget --no-check-certificate https://github.com/powerline/fonts/archive/master.zip
  unzip master.zip
  sh fonts-master/install.sh
  rm -rf master.zip
  rm -rf fonts-master
  fc-cache -f -v
  goToRoot
}

installZshSudo() {
  funcName=$(getFunctionName)
  checkIfSudo $funcName
  if [ "${?}" = "0" ] ; then
    return
  fi;
  goToRoot
  aptGet
  rm -rf /root/.oh-my-zsh
  pip install --user powerline-status
  powerlineFontInstallation
  printf '\n' | sudo apt-get install zsh
  goToRoot
  cd $SYSTEM_SOFTWARE_FOLDER
  #in both sudo and non sudo mode(the below two lines of code only)
  #sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" (either this line or the one below)
  sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
  chsh -s /usr/bin/zsh
  goToRoot
  source ~/.zshrc
  source ~/.bashrc
}

installZoomConference() {
  funcName=$(getFunctionName)
  checkIfSudo $funcName
  if [ "${?}" = "0" ] ; then
    return
  fi;
  cd $SYSTEM_SOFTWARE_FOLDER
  printf '\n' | sudo apt-get install libglib2.0-0 libgstreamer-plugins-base0.10-0 libxcb-shape0 libxcb-shm0 libxcb-xfixes0 libxcb-randr0 libxcb-image0 libfontconfig1 libgl1-mesa-glx libxi6 libsm6 libxrender1 libpulse0 libxcomposite1 libxslt1.1 libsqlite3-0 libxcb-keysyms1 libxcb-xtest0
  wget -O zoom_amd64.deb --no-check-certificate "https://d11yldzmag5yn.cloudfront.net/prod/2.0.106600.0904/zoom_amd64.deb"
  sudo dpkg -i zoom_amd64.deb
  printf 'y\n' | sudo apt-get install -f
}

installRedis() {
  funcName=$(getFunctionName)
  checkIfSudo $funcName
  if [ "${?}" = "0" ] ; then
    return
  fi;
  goToRoot
  cd $SYSTEM_SOFTWARE_FOLDER
  wget http://download.redis.io/redis-stable.tar.gz
  tar xvzf redis-stable.tar.gz
  cd redis-stable
  make
  printf 'y\n' | make install
  rm -rf redis-stable.tar.gz
  goToRoot
}

installRoboMongo() {
  funcName=$(getFunctionName)
  checkIfSudo $funcName
  if [ "${?}" = "0" ] ; then
    return
  fi;
  if [ -z "$1" ]; then
    echo "null value not allowed as first parameter for method: \"${funcName}\"! You must pass the required parameter(s)."
    return $1
  fi;
  if [ -z "$2" ]; then
    echo "null value not allowed as second parameter for method: \"${funcName}\"! You must pass the required parameter(s)."
    return $2
  fi;
  goToRoot
  cd $SYSTEM_SOFTWARE_FOLDER
  rm -rf $2.tar.gz
  rm -rf $2
  rm -rf /usr/local/bin/robomongo
  wget --no-check-certificate https://download.robomongo.org/$1/linux/$2.tar.gz
  tar -xvzf $2.tar.gz
  sudo mkdir -p /usr/local/bin/robomongo
  sudo mv $2/* /usr/local/bin/robomongo
  cd /usr/local/bin/robomongo/bin
  sudo chmod +x robo3t ## run command only if robomongo isn't excutable file
  ./robo3t
  goToRoot
}

installRazerDrivers() {
  funcName=$(getFunctionName)
  checkIfSudo $funcName
  if [ "${?}" = "0" ] ; then
    return
  fi;
  printf '\n' | sudo add-apt-repository ppa:openrazer/stable
  aptGet
  printf 'y\n' | sudo apt install openrazer-meta
  printf '\n' | sudo add-apt-repository ppa:lah7/polychromatic
  aptGet
  printf 'y\n' | sudo apt install polychromatic
}

installPyCharm() {
  funcName=$(getFunctionName)
  checkIfSudo $funcName
  if [ "${?}" = "0" ] ; then
    return
  fi;
  if [ -z "$1" ]; then
    echo "null value not allowed as first parameter for method: \"${funcName}\"! You must pass the required parameter(s)."
    return $1
  fi;
  cd $SYSTEM_SOFTWARE_FOLDER
  wget -O $1.tar.gz --no-check-certificate "https://download.jetbrains.com/python/$1.tar.gz"
  tar xvfz $1.tar.gz
  mkdir -p $SYSTEM_APPS_FOLDER/$1
  rm -rf $SYSTEM_APPS_FOLDER/$1
  mv "$1" "$SYSTEM_APPS_FOLDER/$1"
  rm -rf "$1"
  goToRoot
}

installZshNonSudo() {
  funcName=$(getFunctionName)
  checkIfNotSudo $funcName
  if [ "${?}" = "0" ] ; then
    return
  fi;
  goToRoot
  rm -rf $SYSTEM_ROOT_FOLDER/.oh-my-zsh
  pip install --user powerline-status
  goToRoot
  checkSoftwareFolder
  #sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" (either this line or the one below)
  sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
  chsh -s /usr/bin/zsh
  goToRoot
  source ~/.zshrc
  source ~/.bashrc
}

installAtomExtensionsNonSudo() {
  funcName=$(getFunctionName)
  checkIfNotSudo $funcName
  if [ "${?}" = "0" ] ; then
    return
  fi;
  goToRoot
  apm install minimap
  #apm install linter
  apm install atom-beautify
  apm install file-icons
  apm install pigments
  apm install git-plus
  apm install linter-ui-default
  apm install color-picker
  apm install emmet
  #apm install language-babel
  apm install autocomplete-python
  apm install atom-typescript
  apm install linter-eslint
  apm install busy-signal
  apm install highlight-selected
  apm install intentions
  apm install script
  apm install project-manager
  apm install merge-conflicts
  #apm install activate-power-mode
  apm install linter-jshint
  #apm install nuclide
  apm install autoclose-html
  apm install react
  apm install atom-ide-ui
  apm install ide-typescript
  apm install ide-csharp
  apm install ide-java
  apm install ide-php
  apm install ide-python
  apm install ide-cpp
  apm install language-vue
  apm install teletype
  apm install language-docker
  goToRoot
}

installAtom() {
  funcName=$(getFunctionName)
  checkIfSudo $funcName
  if [ "${?}" = "0" ] ; then
    return
  fi;
  #ALTERNATE METHOD BELOW(commented out because this repo lags way too behind of latest atom version updates)
  #goToRoot
  #aptGet
  #printf '\n' | sudo add-apt-repository ppa:webupd8team/atom
  #aptGet
  #printf 'y\n' | sudo apt-get install atom
  cd $SYSTEM_SOFTWARE_FOLDER
  curl -L https://packagecloud.io/AtomEditor/atom/gpgkey | sudo apt-key add -
  sudo sh -c 'echo "deb [arch=amd64] https://packagecloud.io/AtomEditor/atom/any/ any main" > /etc/apt/sources.list.d/atom.list'
  aptGet
  printf 'y\n' | sudo apt-get install atom
  goToRoot
}

installStacer() {
  funcName=$(getFunctionName)
  if [ -z "$1" ]; then
    echo "null value not allowed as first parameter for method: \"${funcName}\"! You must pass the required parameter(s)."
    return $1
  fi;
  checkIfSudo $funcName
  if [ "${?}" = "0" ] ; then
    return
  fi;
  goToRoot
  aptGet
  cd $SYSTEM_SOFTWARE_FOLDER
  wget -O Stacer_$1_amd64.deb --no-check-certificate https://github.com/oguzhaninan/Stacer/releases/download/v$1/Stacer_$1_amd64.deb
  printf 'y\n' | sudo apt install $SYSTEM_SOFTWARE_FOLDER/Stacer_$1_amd64.deb
  sudo dpkg -i Stacer_$1_amd64.deb
  printf 'y\n' | sudo apt-get install -f
  goToRoot
}

installJenkins() {
  funcName=$(getFunctionName)
  checkIfSudo $funcName
  if [ "${?}" = "0" ] ; then
    return
  fi;
  goToRoot
  aptGet
  cd $SYSTEM_SOFTWARE_FOLDER
  wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
  sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
  aptGet
  printf 'Y\n' | sudo apt-get install jenkins
  goToRoot
}

installPhpmyadmin() {
  funcName=$(getFunctionName)
  checkIfSudo $funcName
  if [ "${?}" = "0" ] ; then
    return
  fi;
  printf 'y\n' | sudo apt-get install mysql-server
  sudo mysql_secure_installation
  printf 'y\n' | sudo apt-get install phpmyadmin php-mbstring php-gettext
  #https://www.digitalocean.com/community/tutorials/how-to-install-and-secure-phpmyadmin-on-ubuntu-16-04
}

installLaravelNonSudo() {
  funcName=$(getFunctionName)
  checkIfNotSudo $funcName
  if [ "${?}" = "0" ] ; then
    return
  fi;
  composer global require "laravel/installer"
  echo 'export PATH="$PATH:$HOME/.composer/vendor/bin"' >> ~/.bash_aliases
  bash_refresh
  #http://vaguelyuseful.info/2016/08/03/installing-laravel-5-2-on-ubuntu-16-04-and-apache2/
}

installSkype() {
  funcName=$(getFunctionName)
  checkIfSudo $funcName
  if [ "${?}" = "0" ] ; then
    return
  fi;
  cd $SYSTEM_SOFTWARE_FOLDER
  wget -O skypeforlinux-64.deb --no-check-certificate "https://repo.skype.com/latest/skypeforlinux-64.deb"
  sudo dpkg -i skypeforlinux-64.deb
  rm -rf skypeforlinux-64.deb
  goToRoot
  #below is the old installation of skype
  #dpkg -s apt-transport-https > /dev/null || bash -c "sudo apt-get update; sudo apt-get install apt-transport-https -y"
  #curl https://repo.skype.com/data/SKYPE-GPG-KEY | sudo apt-key add -
  #echo "deb [arch=amd64] https://repo.skype.com/deb stable main" | sudo tee /etc/apt/sources.list.d/skype-stable.list
  #aptGet
  #sudo apt-get install skypeforlinux -y
}

installSlack() {
  funcName=$(getFunctionName)
  checkIfSudo $funcName
  if [ "${?}" = "0" ] ; then
    return
  fi;
  if [ -z "$1" ]; then
    echo "null value not allowed as first parameter for method: \"${funcName}\"! You must pass the required parameter(s)."
    return $1
  fi;
  cd $SYSTEM_SOFTWARE_FOLDER
  wget -O slack-desktop-$1-amd64.deb --no-check-certificate "https://downloads.slack-edge.com/linux_releases/slack-desktop-$1-amd64.deb"
  sudo dpkg -i slack-desktop-$1-amd64.deb
  rm -rf slack-desktop-$1-amd64.deb
  goToRoot
}

installGnome() {
  funcName=$(getFunctionName)
  checkIfSudo $funcName
  if [ "${?}" = "0" ] ; then
    return
  fi;
  printf 'y\n' | sudo apt-get install gnome
  printf 'y\n' | sudo apt-get install gnome-shell
  printf 'y\n' | sudo apt install gnome-control-center gnome-online-accounts
}

installRabbitMq() {
  funcName=$(getFunctionName)
  checkIfSudo $funcName
  if [ "${?}" = "0" ] ; then
    return
  fi;
  echo 'deb http://www.rabbitmq.com/debian/ testing main' | sudo tee /etc/apt/sources.list.d/rabbitmq.list
  wget -O- https://www.rabbitmq.com/rabbitmq-release-signing-key.asc | sudo apt-key add -
  aptGet
  printf 'y\n' | sudo apt-get install rabbitmq-server
}

installPostman() {
  funcName=$(getFunctionName)
  checkIfSudo $funcName
  if [ "${?}" = "0" ] ; then
    return
  fi;
  wget https://dl.pstmn.io/download/latest/linux64 -O postman.tar.gz --no-check-certificate
  tar -xzf postman.tar.gz -C /opt
  rm postman.tar.gz
  rm -rf /usr/bin/postman
  ln -s /opt/Postman/Postman /usr/bin/postman
  export PATH="$PATH:/usr/bin/postman"

 cat > ~/.local/share/applications/postman.desktop <<EOL
  [Desktop Entry]
  Encoding=UTF-8
  Name=Postman
  Exec=postman
  Icon=/opt/Postman/resources/app/assets/icon.png
  Terminal=false
  Type=Application
  Categories=Development;
EOL
}

installWine() {
  funcName=$(getFunctionName)
  checkIfSudo $funcName
  if [ "${?}" = "0" ] ; then
    return
  fi;
  aptGet
  printf 'y\n' | sudo apt remove wine2.0 wine-staging wine wine1.8 wine-stable libwine* fonts-wine*
  aptGet
  printf "y\n" | sudo apt autoremove
  aptGet
  printf '\n' | sudo add-apt-repository --remove ppa:wine/wine-builds
  sudo dpkg --add-architecture i386
  wget -nc https://dl.winehq.org/wine-builds/Release.key
  sudo apt-key add Release.key
  printf '\n' | sudo apt-add-repository 'https://dl.winehq.org/wine-builds/ubuntu/'
  aptGet
  printf 'y\n' | sudo apt-get install --install-recommends wine-staging
  /opt/wine-staging/bin/wine
  /opt/wine-staging/bin/winecfg
}

installGolang() {
  if [ -z "$1" ]; then
    echo "null value not allowed as first parameter for method: \"${funcName}\"! You must pass the required parameter(s)."
    return $1
  fi;
  if [ -z "$2" ]; then
    echo "null value not allowed as second parameter for method: \"${funcName}\"! You must pass the required parameter(s)."
    return $2
  fi;
  cd $SYSTEM_SOFTWARE_FOLDER
  rm -rf $2.tar.gz
  rm -rf "go"
  rm -rf $SYSTEM_APPS_FOLDER/$2
  wget -O $2.tar.gz --no-check-certificate https://redirector.gvt1.com/edgedl/go/$2.tar.gz
  tar xvfz $2.tar.gz
  mkdir -p $SYSTEM_APPS_FOLDER/$2
  mv "$SYSTEM_SOFTWARE_FOLDER/go/" "$SYSTEM_APPS_FOLDER/$2"
  chmod $DEFAULT_PERMISSION_VALUE $SYSTEM_APPS_FOLDER/$2
  rm -rf $2.tar.gz
  rm -rf "go"
  export PATH="$PATH:$SYSTEM_APPS_FOLDER/$2/go/bin"
  goToRoot
}

installPhantomJs() {
  funcName=$(getFunctionName)
  checkIfSudo $funcName
  if [ "${?}" = "0" ] ; then
    return
  fi;
  if [ -z "$1" ]; then
    echo "null value not allowed as first parameter for method: \"${funcName}\"! You must pass the required parameter(s)."
    return $1
  fi;
  if [ -z "$2" ]; then
    echo "null value not allowed as second parameter for method: \"${funcName}\"! You must pass the required parameter(s)."
    return $2
  fi;
  cd $SYSTEM_SOFTWARE_FOLDER/
  rm -rf /usr/local/share/phantomjs
  rm -rf /usr/local/bin/phantomjs
  rm -rf /usr/bin/phantomjs
  cd /usr/local/share
  rm -rf $1.tar.bz2
  #wget -O $1.tar.bz2 https://github.com/Medium/phantomjs/releases/download/v$2/$1.tar.bz2
  wget -O $1.tar.bz2 https://bitbucket.org/ariya/phantomjs/downloads/$1.tar.bz2
  tar xvfz $1.tar.bz2
  phantomjs --version
  rm -rf $1.tar.bz2
  export PATH="$PATH:/usr/local/share/$1/bin"
  goToRoot
}

installMonoDevelop() {
  funcName=$(getFunctionName)
  checkIfSudo $funcName
  if [ "${?}" = "0" ] ; then
    return
  fi;
  printf '\n' | sudo add-apt-repository ppa:alexlarsson/flatpak
  aptGet
  printf 'y\n' | sudo apt install flatpak
  flatpak install --user --from https://download.mono-project.com/repo/monodevelop.flatpakref
  #type and enter 'y' twice
}

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

installHerokuToolbelt() {
  funcName=$(getFunctionName)
  checkIfSudo $funcName
  if [ "${?}" = "0" ] ; then
    return
  fi;
  aptGet
  cd $SYSTEM_SOFTWARE_FOLDER/
  #wget -O- https://toolbelt.heroku.com/install-ubuntu.sh | sh
  printf '\n' | sudo add-apt-repository "deb https://cli-assets.heroku.com/branches/stable/apt ./"
  curl -L https://cli-assets.heroku.com/apt/release.key | sudo apt-key add -
  aptGet
  printf 'y\n' | sudo apt-get install heroku
  goToRoot
}

installVirtualBox() {
  funcName=$(getFunctionName)
  checkIfSudo $funcName
  if [ "${?}" = "0" ] ; then
    return
  fi;
  # Install virtual-box
  goToRoot
  aptGet
  printf 'y\n' | sudo apt install virtualbox virtualbox-ext-pack
  # press tab and then enter when prompted
  goToRoot
}

installJava() {
  funcName=$(getFunctionName)
  checkIfSudo $funcName
  if [ "${?}" = "0" ] ; then
    return
  fi;
  # Install Java 9
  goToRoot
  sudo add-apt-repository -y ppa:webupd8team/java
  aptGet
  echo "oracle-java9-installer shared/accepted-oracle-license-v1-1 select true" | sudo debconf-set-selections
  sudo apt-get install -y oracle-java9-installer
  goToRoot
}

installAngryIpScan() {
  funcName=$(getFunctionName)
  checkIfSudo $funcName
  if [ "${?}" = "0" ] ; then
    return
  fi;
  if [ -z "$1" ]; then
    echo "null value not allowed as first parameter for method: \"${funcName}\"! You must pass the required parameter(s)."
    return $1
  fi;
  aptGet
  cd $SYSTEM_SOFTWARE_FOLDER/
  wget -O ipscan_$1_amd64.deb https://github.com/angryip/ipscan/releases/download/$1/ipscan_$1_amd64.deb
  sudo dpkg -i ipscan_$1_amd64.deb
  printf 'y\n' | sudo apt-get install -f
  goToRoot
}

installClangD() {
  funcName=$(getFunctionName)
  checkIfSudo $funcName
  if [ "${?}" = "0" ] ; then
    return
  fi;
  if [ -z "$1" ]; then
    echo "null value not allowed as first parameter for method: \"${funcName}\"! You must pass the required parameter(s)."
    return $1
  fi;
  aptGet
  cd $SYSTEM_SOFTWARE_FOLDER/
  #TODO: replace 5.0 value in the next 2 lines with $1 variable value
  sudo sh -c 'echo "deb http://apt.llvm.org/$(lsb_release -sc)/ llvm-toolchain-$(lsb_release -sc)-5.0 main" >> /etc/apt/sources.list'
  sudo sh -c 'echo "deb-src http://apt.llvm.org/$(lsb_release -sc)/ llvm-toolchain-$(lsb_release -sc)-5.0 main" >> /etc/apt/sources.list'
  aptGet
  wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key|sudo apt-key add -
  printf 'y\n' | sudo apt-get install clang-$1 lldb-$1
  printf 'y\n' | sudo apt-get install clang-$1 clang-tools-$1 clang-$1-doc libclang-common-$1-dev libclang-$1-dev libclang1-$1 libclang1-$1-dbg libllvm$1 libllvm$1-dbg lldb-$1 llvm-$1 llvm-$1-dev llvm-$1-doc llvm-$1-examples llvm-$1-runtime clang-format-$1 python-clang-$1 libfuzzer-$1-dev
  printf 'y\n' | sudo apt-get install libllvm-$1-ocaml-dev
  goToRoot
}

installNginx() {
  funcName=$(getFunctionName)
  checkIfSudo $funcName
  if [ "${?}" = "0" ] ; then
    return
  fi;
  goToRoot
  sudo service apache2 stop
  printf "y\n" | sudo apt-get install nginx
  sudo ufw allow 'Nginx Full'
  sudo ufw allow 'Nginx HTTP'
  sudo ufw allow 'Nginx HTTPS'
  sudo service apache2 start
  goToRoot
}

installCodeblocks() {
  funcName=$(getFunctionName)
  checkIfSudo $funcName
  if [ "${?}" = "0" ] ; then
    return
  fi;
  goToRoot
  printf '\n' | sudo add-apt-repository ppa:damien-moore/codeblocks-stable
  aptGet
  printf 'y\n' | sudo apt-get install codeblocks codeblocks-contrib
  goToRoot
}

installPackagesForSystemSudo() {
  funcName=$(getFunctionName)
  checkIfSudo $funcName
  if [ "${?}" = "0" ] ; then
    return
  fi;
  goToRoot
  coreSystemUpdate
  # Install build essentials
  printf 'y\n' | sudo apt-get install build-essential autoconf automake unzip curl gcc g++ wget sshpass pwgen tree xclip zip preload nano vim lsof checkinstall software-properties-common debconf-utils htop
  printf 'y\n' | sudo apt-get install ubuntu-desktop compizconfig-settings-manager ffmpeg gpick
  printf 'y\n' | sudo apt-get install libc6:i386 libncurses5:i386 libstdc++6:i386 lib32z1 libbz2-1.0:i386
  printf 'y\n' | sudo apt-get install gradle
  printf 'y\n' | sudo apt-get install android-tools-adb
  # Install package for ubuntu app location restore feature after machine restart
  printf 'y\n' | sudo apt-get install wmctrl
  # Install nmap
  printf 'y\n' | sudo apt-get install nmap
  # Install ubuntu make
  printf '\n' | sudo add-apt-repository ppa:ubuntu-desktop/ubuntu-make
  aptGet
  # Install open vpn
  printf 'y\n' | sudo apt-get install openvpn easy-rsa
  aptGet
  printf 'y\n' | sudo apt-get install ubuntu-make
  # Install python and postgres
  installPythonAndPostgres
  # Install C++ code beautifier
  printf 'y\n' | sudo apt-get install uncrustify
  # Install tweak tools
  #printf 'y\n' | sudo apt-get install unity-tweak-tool
  printf 'y\n' | sudo apt-get install gnome-tweak-tool
  aptGet
  # Install youtube video downloader
  printf 'y\n' | sudo apt-get install youtube-dl
  # Install Codeblocks
  installCodeblocks
  # Install expect
  printf "y\n" | sudo apt-get install expect expect-dev
  # Install media players
  aptGet
  printf "y\n" | sudo apt-get install banshee
  printf "\n" | sudo add-apt-repository ppa:me-davidsansome/clementine
  aptGet
  printf "y\n" | sudo apt-get install clementine
  # Install Etcher
  touch /etc/apt/sources.list.d/etcher.list
  echo "deb https://dl.bintray.com/resin-io/debian stable etcher" | tee /etc/apt/sources.list.d/etcher.list
  sudo apt-key adv --keyserver hkp://pgp.mit.edu:80 --recv-keys 379CE192D401AB61
  aptGet
  printf "y\n" | sudo apt-get install etcher-electron
  # Install Spotify
  sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys BBEBDCB318AD50EC6865090613B00F1FD2C19886
  echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list
  aptGet
  printf "y\n" | sudo apt-get install spotify-client
  # Install New fetch
  printf "\n" | sudo add-apt-repository ppa:dawidd0811/neofetch
  aptGet
  printf "y\n" | sudo apt install neofetch
  #Install Adobe Flash Player
  printf 'y\n' | sudo apt-get install flashplugin-installer
  # Install Filezilla FTP
  printf 'y\n' | sudo apt-get install filezilla
  # Install VLC
  printf 'y\n' | sudo apt-get install vlc browser-plugin-vlc
  # Install sublime text 3
  printf '\n' | sudo add-apt-repository ppa:webupd8team/sublime-text-3
  aptGet
  printf 'y\n' | sudo apt-get install sublime-text-installer
  # Install Atom
  installAtom
  # Install Unrar
  printf 'y\n' | sudo apt-get install unrar
  # Install Transmission client
  printf '\n' | sudo add-apt-repository ppa:transmissionbt/ppa
  aptGet
  printf 'y\n' | sudo apt-get install transmission-gtk transmission-cli transmission-common transmission-daemon
  # Install GIMP
  printf 'y\n' | sudo apt-get install gimp gimp-data gimp-plugin-registry gimp-data-extras
  aptGet
  # Install postgis
  printf "y\n" | sudo apt-get install postgis
  # Install Synaptic
  printf 'y\n' | sudo apt-get install synaptic
  # Install Laptop mode tools
  printf 'y\n' | sudo apt-get install laptop-mode-tools
  # Install microphone control panel and pulseaudio android support package
  aptGet
  printf 'y\n' | sudo apt-get install pavucontrol
  aptGet
  printf '\n' | sudo add-apt-repository ppa:qos/pulseaudio-dlna
  aptGet
  printf 'y\n' | sudo apt-get install pulseaudio-dlna
  # Install noobs-lab icons
  printf '\n' | sudo add-apt-repository ppa:noobslab/icons
  aptGet
  printf 'y\n' | sudo apt-get install ultra-flat-icons ultra-flat-icons-green ultra-flat-icons-orange
  # Postman installation
  installPostman
  # Stacer installation
  installStacer $LATEST_STACER_VERSION
  # Docker installation
  installDocker
  # Install Heroku toolbelt
  installHerokuToolbelt
  # Install Jenkins
  installJenkins
  # Install line of code count for git repo
  aptGet
  printf 'y\n' | sudo apt-get install cloc
  # Install php
  installPhp
  # Install skype
  aptGet
  installSkype
  # Install Redis
  installRedis
  # Install rabbit mq
  aptGet
  installRabbitMq
  rabbitMqRestart
  # Install Geos
  installGeos
  # Install Open ssh
  printf 'y\n' | sudo apt-get install openssh-server
  sudo service ssh restart
  # Install blender
  installBlender
  # Install Ansible
  aptGet
  printf "\n" | sudo apt-add-repository ppa:ansible/ansible
  aptGet
  printf "y\n" | sudo apt-get install ansible
  # Install ngnix
  installNginx
  # Install Bracket editor
  installBracket $LATEST_BRACKET_VERSION
  # Install vscode editor
  installVisualStudioCode $LATEST_VSCODE_FILE_NAME
  # Install java
  installJava
  # Install pycharm
  installPyCharm $LATEST_PYCHARM_VERSION
  # Install slack chat app
  installSlack $LATEST_SLACK_VERSION
  # Install powerline fonts
  powerlineFontInstallationSudo
  # Install ZSH
  aptGet
  installZshSudo
  # Install gparted
  aptGet
  printf "y\n" | sudo apt-get install gparted
  # Install 7z unpacking package
  aptGet
  printf "y\n" | sudo apt-get install p7zip-full
  # Install nodejs
  installNodejs
  goToRoot
}

installPackagesForSystemNonSudoFirst() {
  funcName=$(getFunctionName)
  checkIfNotSudo $funcName
  if [ "${?}" = "0" ] ; then
    return
  fi;
  checkRootVirtualPythonEnvironmentFolder
  checkSoftwareFolder
  checkAppsFolder
  checkMusicVideosFolder
  goToRoot
  echo "FOLDER CREATION COMPLETED."
}

installPackagesForSystemSudoSecond() {
  funcName=$(getFunctionName)
  checkIfSudo $funcName
  if [ "${?}" = "0" ] ; then
    return
  fi;
  installPackagesForSystemSudo
  echo "SYSTEM PACKAGE INSTALLATION COMPLETED. YOU MAY REBOOT YOUR SYSTEM NOW."
}

installPackagesForSystemNonSudoThird() {
  funcName=$(getFunctionName)
  checkIfNotSudo $funcName
  if [ "${?}" = "0" ] ; then
    return
  fi;
  installZshNonSudo
  powerlineFontInstallationNonSudo
  installVSCodeExtensionsNonSudo
  installAtomExtensionsNonSudo
  postgresPgpassFileInit
  echo "SYSTEM PACKAGE INSTALLATION FOR NON SUDO USER COMPLETED."
}

alias install_angry_ip_scan="installAngryIpScan $LATEST_ANGRY_IP_SCAN_VERSION"
alias install_atom=installAtom
alias install_atom_extensions=installAtomExtensionsNonSudo
alias install_blender=installBlender
alias install_bracket="installBracket $LATEST_BRACKET_VERSION"
alias install_clangd="installClangD $LATEST_CLANGD_VERSION"
alias install_codeblocks=installCodeblocks
alias install_golang="installGolang $LATEST_GOLANG_VERSION $LATEST_GOLANG_VERSION_FULL"
alias install_hack_lang=installHackLang
alias install_nginx=installNginx
alias install_java=installJava
alias install_jenkins=installJenkins
alias install_laravel=installLaravelNonSudo
alias install_mongo=installMongoDb
alias install_mono_develop=installMonoDevelop #type and enter 'y' character twice when prompted
alias install_phantom="installPhantomJs $LATEST_PHANTOMJS_VERSION_FULL $LATEST_PHANTOMJS_VERSION"
alias install_php=installPhp
alias install_postman=installPostman
alias install_pycharm="installPyCharm $LATEST_PYCHARM_VERSION"
alias install_python=installPython
alias install_python_postgres=installPythonAndPostgres
alias install_robo_mongo="installRoboMongo $LATEST_ROBOMONGO_VERSION $LATEST_ROBOMONGO_VERSION_FULL"
alias install_slack="installSlack $LATEST_SLACK_VERSION"
alias install_virtual_box=installVirtualBox
alias install_vscode="installVisualStudioCode $LATEST_VSCODE_FILE_NAME"
alias install_zoom="installZoomConference"
alias system_init_non_sudo_first=installPackagesForSystemNonSudoFirst
alias system_init_non_sudo_second=installPackagesForSystemNonSudoThird
alias system_init_sudo=installPackagesForSystemSudoSecond
