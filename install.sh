#!/bin/bash

LATEST_PYCHARM_VERSION="pycharm-community-2017.3.1"
LATEST_SMARTGIT_FILE_NAME="smartgit-17_1_3.deb"
LATEST_VSCODE_FILE_NAME="code_1.19.0-1513245498_amd64.deb"
LATEST_SLACK_VERSION="3.0.0"
LATEST_ROBOMONGO_VERSION="1.1.1"
LATEST_ROBOMONGO_VERSION_FULL="robo3t-$LATEST_ROBOMONGO_VERSION-linux-x86_64-c93c6b0"

LATEST_GEOS_VERSION="geos-3.6.1"
LATEST_POSTGIS_VERSION="postgis-2.3.3"
LATEST_PYTHON_VERSION="3.6.3"
LATEST_BRACKET_VERSION="1.11"
LATEST_STACER_VERSION="1.0.6"

apmUpdates() {
  funcName=$(getFunctionName)
  checkIfNotSudo $funcName
  if [ "${?}" = "0" ] ; then
    return
  fi;
  printf "yes\n" | apm update
  printf "yes\n" | apm upgrade
}

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
  #geo-spatial packages
  printf 'y\n' | sudo apt-get install binutils libproj-dev gdal-bin libgdal-dev postgis
  checkSoftwareFolder
  sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -sc)-pgdg main" >> /etc/apt/sources.list'
  wget --quiet -O - http://apt.postgresql.org/pub/repos/apt/ACCC4CF8.asc | sudo apt-key add -
  aptGet
  sudo apt-get install -y postgresql-9.6
  sudo apt-get install -y postgresql-9.6-postgis-2.3-scripts
  sudo apt-get install -y postgresql-contrib-9.6
  aptGet
  printf "y\n" | sudo apt autoremove
  aptGet
  wget http://postgis.net/stuff/$LATEST_POSTGIS_VERSION.tar.gz
  tar xvfz $LATEST_POSTGIS_VERSION.tar.gz
  cd $LATEST_POSTGIS_VERSION
  ./configure
  make
  make install
  cd ..
  rm -rf $LATEST_POSTGIS_VERSION.tar.gz
  rm -rf $LATEST_POSTGIS_VERSION
  goToRoot
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
  pip install --upgrade docker-compose
  pip install --upgrade awscli
  pip install --upgrade pyOpenSSL==16.2.0
  pip install --upgrade selenium
  pip install --upgrade python-language-server
  sudo service postgresql restart
  #the following command is for postgis installation in postgres in 9.3
  #sudo apt-get install postgresql-9.3-postgis-scripts postgresql-9.3-postgis-2.1-scripts
}
installPythonAndPostgres() {
  funcName=$(getFunctionName)
  checkIfSudo $funcName
  if [ "${?}" = "0" ] ; then
    return
  fi;
  goToRoot
  aptGet
  printf 'y\n' | sudo apt-get install python-software-properties python-pip python-dev python3-dev libpq-dev postgresql postgresql-contrib pgadmin3 libxml2-dev libxslt1-dev libjpeg-dev python-gpgme python-coverage
  printf 'y\n' | sudo apt-get install python-lxml python-cffi libcairo2 libpango1.0-0 libgdk-pixbuf2.0-0 shared-mime-info libxslt-dev libffi-dev libcairo2-dev libpango1.0-dev libreadline-gplv2-dev libncursesw5-dev libssl-dev libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev
  printf 'y\n' | sudo apt-get install python-pyaudio python-numpy
  printf 'y\n' | sudo apt-get install postgresql-server-dev-9.5
  #geo-spatial packages
  printf 'y\n' | sudo apt-get install binutils libproj-dev gdal-bin libgdal-dev postgis
  checkSoftwareFolder
  sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -sc)-pgdg main" >> /etc/apt/sources.list'
  wget --quiet -O - http://apt.postgresql.org/pub/repos/apt/ACCC4CF8.asc | sudo apt-key add -
  aptGet
  sudo apt-get install -y postgresql-9.6
  sudo apt-get install -y postgresql-9.6-postgis-2.3-scripts
  sudo apt-get install -y postgresql-contrib-9.6
  aptGet
  printf "y\n" | sudo apt autoremove
  aptGet
  wget http://postgis.net/stuff/$LATEST_POSTGIS_VERSION.tar.gz
  tar xvfz $LATEST_POSTGIS_VERSION.tar.gz
  cd $LATEST_POSTGIS_VERSION
  ./configure
  make
  make install
  cd ..
  rm -rf $LATEST_POSTGIS_VERSION.tar.gz
  rm -rf $LATEST_POSTGIS_VERSION
  goToRoot
  pip install --upgrade pip WeasyPrint apiai django virtualenv jsbeautifier autopep8 isort coursera-dl setuptools html5lib docker-compose awscli pyOpenSSL==16.2.0 selenium python-language-server pylint coverage
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
  checkSoftwareFolder
  cd $softwareFolder/
  wget http://download.osgeo.org/geos/$LATEST_GEOS_VERSION.tar.bz2
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
  wget https://www.python.org/ftp/python/$LATEST_PYTHON_VERSION/Python-$LATEST_PYTHON_VERSION.tgz
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
  checkSoftwareFolder
  printf '\n' | sudo add-apt-repository ppa:webupd8team/brackets
  aptGet
  printf 'y\n' | sudo apt-get install brackets
  #wget https://github.com/adobe/brackets/releases/download/release-$1/Brackets.Release.$1.64-bit.deb
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
  checkSoftwareFolder
  printf 'y\n' | sudo apt-get install gvfs-bin
  wget -O $1 "https://go.microsoft.com/fwlink/?LinkID=760868"
  #wget --no-check-certificate https://az764295.vo.msecnd.net/stable/e6b4afa53e9c0f54edef1673de9001e9f0f547ae/code_1.3.1-1468329898_amd64.deb
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
  sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/microsoft-ubuntu-xenial-prod \"$(lsb_release -sc)\" main" > /etc/apt/sources.list.d/dotnetdev.list'
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
  sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
  # Dependent on ubuntu version
  echo "deb http://repo.mongodb.org/apt/ubuntu "$(lsb_release -sc)"/mongodb-org/3.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list
  aptGet
  printf 'y\n' | sudo apt-get install -y mongodb-org
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
  checkSoftwareFolder
  wget --no-check-certificate https://github.com/powerline/fonts/archive/master.zip
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
  checkSoftwareFolder
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
  checkSoftwareFolder
  printf '\n' | sudo apt-get install libglib2.0-0 libgstreamer-plugins-base0.10-0 libxcb-shape0 libxcb-shm0 libxcb-xfixes0 libxcb-randr0 libxcb-image0 libfontconfig1 libgl1-mesa-glx libxi6 libsm6 libxrender1 libpulse0 libxcomposite1 libxslt1.1 libsqlite3-0 libxcb-keysyms1 libxcb-xtest0
  wget -O zoom_amd64.deb "https://d11yldzmag5yn.cloudfront.net/prod/2.0.106600.0904/zoom_amd64.deb"
  sudo dpkg -i zoom_amd64.deb
  printf 'y\n' | sudo apt-get install -f
}

installSmartgit() {
  funcName=$(getFunctionName)
  checkIfSudo $funcName
  if [ "${?}" = "0" ] ; then
    return
  fi;
  if [ -z "$1" ]; then
    echo "null value not allowed as first parameter for method: \"${funcName}\"! You must pass the required parameter(s)."
    return $1
  fi;
  checkSoftwareFolder
  wget -O $1 "http://www.syntevo.com/static/smart/download/smartgit/$1"
  printf 'y\n' | sudo apt install $1
  sudo dpkg -i $1
  printf 'y\n' | sudo apt-get install -f
}

installRedis() {
  funcName=$(getFunctionName)
  checkIfSudo $funcName
  if [ "${?}" = "0" ] ; then
    return
  fi;
  goToRoot
  checkSoftwareFolder
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
  checkSoftwareFolder
  wget https://download.robomongo.org/$1/linux/$2.tar.gz
  tar -xvzf $2.tar.gz
  sudo mkdir -p /usr/local/bin/robomongo
  sudo mv $2/* /usr/local/bin/robomongo
  cd /usr/local/bin/robomongo/bin
  sudo chmod +x robomongo ## run command only if robomongo isn't excutable file
  ./robomongo
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
  checkSoftwareFolder
  wget -O $1.tar.gz "https://download.jetbrains.com/python/$1.tar.gz"
  tar xvfz $1.tar.gz
  mkdir -p $SYSTEM_APPS_FOLDER/$1
  rm -rf $SYSTEM_APPS_FOLDER/$1
  mv "$1" "$SYSTEM_APPS_FOLDER/$1"
  rm -rf "$1"
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
  apm install activate-power-mode
  apm install linter-jshint
  #apm install nuclide
  apm install autoclose-html
  #apm install react
  apm install atom-ide-ui
  apm install ide-typescript
  apm install ide-csharp
  apm install ide-java
  apm install ide-php
  apm install ide-python
  apm install ide-cpp
  goToRoot
}

installAtom() {
  funcName=$(getFunctionName)
  checkIfSudo $funcName
  if [ "${?}" = "0" ] ; then
    return
  fi;
  #goToRoot
  #aptGet
  #printf '\n' | sudo add-apt-repository ppa:webupd8team/atom
  #aptGet
  #printf 'y\n' | sudo apt-get install atom
  #ALTERNATE METHOD BELOW(commented out)
  checkSoftwareFolder
  wget --no-check-certificate https://atom.io/download/deb
  mv "deb" "atom-amd64.deb"
  sudo dpkg -i atom-amd64.deb
  sudo apt-get install -f
  rm -rf atom-amd64.deb
  goToRoot
}

installSmartgitByCrawl() {
  funcName=$(getFunctionName)
  checkIfSudo $funcName
  if [ "${?}" = "0" ] ; then
    return
  fi;
  # TODO: finish this implementation
  # Download the smartgit from website first and place it in the downloads folder
  if [ -z "$1" ]; then
    echo "null value not allowed as first parameter for method: \"${funcName}\"! You must pass the required parameter(s)."
    return $1
  fi;
  fileName=""
  startPartternString="<a href=\"./download?file=smartgit"
  endPartternString="\""
  dataString=$(getWebsiteData "http://www.syntevo.com/smartgit/download")
  dataStringLen=${#dataString}
  startPartternStringLen=${#startPartternString}
  endPartternStringLen=${#endPartternString}
  dataStringLen=$(($dataStringLen-1))
  for i in {0..$dataStringLen}; do
    limitEnd=$(($i+$startPartternStringLen-1))
    substring=''
    for j in {$i..$limitEnd}; do
      singleChar=${dataString:$j:1}
      substring=$substring$singleChar
    done
    if [[ "$substring" == "$startPartternString" ]]; then
      #res=''
      #limitStart=$(($limitEnd+1))
      #substring=''
      #for j in {$limitStart..$dataStringLen}; do
      #  singleChar=${dataString:$j:1}
      #  substring=$substring$singleChar
      #done
      echo "$substring"
    fi
  done
  printf 'y\n' | sudo apt install $fileName
  sudo dpkg -i $fileName
  printf 'y\n' | sudo apt-get install -f
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
  checkSoftwareFolder
  wget https://github.com/oguzhaninan/Stacer/releases/download/v$1/Stacer_$1_amd64.deb
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
  checkSoftwareFolder
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
  checkSoftwareFolder
  wget -O skypeforlinux-64.deb "https://repo.skype.com/latest/skypeforlinux-64.deb"
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
  checkSoftwareFolder
  wget -O slack-desktop-$1-amd64.deb "https://downloads.slack-edge.com/linux_releases/slack-desktop-$1-amd64.deb"
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
  wget https://dl.pstmn.io/download/latest/linux64 -O postman.tar.gz
  tar -xzf postman.tar.gz -C /opt
  rm postman.tar.gz
  ln -s /opt/Postman/Postman /usr/bin/postman

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

installMonoDevelop() {
  funcName=$(getFunctionName)
  checkIfSudo $funcName
  if [ "${?}" = "0" ] ; then
    return
  fi;
  printf '\n' | sudo add-apt-repository ppa:alexlarsson/flatpak
  aptGet
  printf 'y\n' | sudo apt install flatpak
  printf 'y\n' | flatpak install --user --from https://download.mono-project.com/repo/monodevelop.flatpakref
}

installPhp() {
  funcName=$(getFunctionName)
  checkIfSudo $funcName
  if [ "${?}" = "0" ] ; then
    return
  fi;
  aptGet
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
}

installDocker() {
  funcName=$(getFunctionName)
  checkIfSudo $funcName
  if [ "${?}" = "0" ] ; then
    return
  fi;
  aptGet
  printf "y\n" | sudo apt-get install apt-transport-https ca-certificates
  printf "y\n" | sudo apt-get install linux-image-extra-$(uname -r) linux-image-extra-virtual
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
  sudo apt-key fingerprint 0EBFCD88
  printf 'y\n' | sudo apt-get install docker-ce
  #sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
  #aptGet
  # Dependent on ubuntu version
  #printf '\n' | sudo add-apt-repository 'deb https://apt.dockerproject.org/repo ubuntu-"$(lsb_release -sc)" main'
  #printf 'y\n' | sudo apt-get install docker-engine
  #sudo apt-cache policy docker-engine
  sudo service docker start
  usermod -aG docker ${USER}
}

installSublime() {
  funcName=$(getFunctionName)
  checkIfSudo $funcName
  if [ "${?}" = "0" ] ; then
    return
  fi;
  wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
  printf 'y\n' | sudo apt-get install apt-transport-https
  echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
  aptGet
  printf 'y\n' | sudo apt-get install sublime-text
}

installHerokuToolbelt() {
  funcName=$(getFunctionName)
  checkIfSudo $funcName
  if [ "${?}" = "0" ] ; then
    return
  fi;
  aptGet
  #wget -O- https://toolbelt.heroku.com/install-ubuntu.sh | sh
  printf '\n' | sudo add-apt-repository "deb https://cli-assets.heroku.com/branches/stable/apt ./"
  curl -L https://cli-assets.heroku.com/apt/release.key | sudo apt-key add -
  aptGet
  printf 'y\n' | sudo apt-get install heroku
}

installVirtualBox() {
  # Install virtual-box
  printf 'y\n' | sudo apt install virtualbox virtualbox-ext-pack
}

installJava() {
  funcName=$(getFunctionName)
  checkIfSudo $funcName
  if [ "${?}" = "0" ] ; then
    return
  fi;
  # Install Java 8
  sudo add-apt-repository -y ppa:webupd8team/java
  aptGet
  echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | sudo debconf-set-selections
  sudo apt-get install -y oracle-java8-installer
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
  printf 'y\n' | sudo apt-get install build-essential autoconf automake unzip curl gcc g++ wget sshpass pwgen tree xclip zip upstart preload nano vim lsof checkinstall software-properties-common libav-tools debconf-utils htop
  printf 'y\n' | sudo apt-get install ubuntu-desktop unity compizconfig-settings-manager ffmpeg gpick
  printf 'y\n' | sudo apt-get install libc6:i386 libncurses5:i386 libstdc++6:i386 lib32z1 libbz2-1.0:i386
  printf 'y\n' | sudo apt-get install gradle
  printf 'y\n' | sudo apt-get install android-tools-adb
  # Install package for ubuntu app location restore feature after machine restart
  printf 'y\n' | sudo apt-get install wmctrl
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
  # Install tweak tool
  printf 'y\n' | sudo apt-get install unity-tweak-tool gnome-tweak-tool
  aptGet
  # Install youtube video downloader
  printf 'y\n' | sudo apt-get install youtube-dl
  # Install Codeblocks
  printf 'y\n' | sudo apt-get install codeblocks
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
  # Install noobs-lacb icons
  printf '\n' | sudo add-apt-repository ppa:noobslab/icons
  aptGet
  printf 'y\n' | sudo apt-get install ultra-flat-icons ultra-flat-icons-green ultra-flat-icons-orange
  # Postman installation
  install_postman
  # Stacer installation
  installStacer $LATEST_STACER_VERSION
  # Docker installation
  installDocker
  # Install Heroku toolbelt
  installHerokuToolbelt
  # Install Jenkins
  installJenkins
  # Install mono develop
  installMonoDevelop
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
  # Install powerline fonts
  powerlineFontInstallationSudo
  # Install ZSH
  aptGet
  installZshSudo
  # Install blender
  installBlender
  # Install Ansible
  aptGet
  printf "\n" | sudo apt-add-repository ppa:ansible/ansible
  aptGet
  printf "y\n" | sudo apt-get install ansible
  # Install ngnix
  sudo service apache2 stop
  printf "y\n" | sudo apt-get install nginx
  sudo ufw allow 'Nginx Full'
  sudo ufw allow 'Nginx HTTP'
  sudo ufw allow 'Nginx HTTPS'
  sudo service apache2 start
  # Install Bracket editor
  install_bracket
  # Install vscode editor
  install_vscode
  # Install java
  install_java
  # Install smartgit
  install_smartgit
  # Install pycharm
  install_pycharm
  # Install slack chat app
  install_slack
  goToRoot
}

installPackagesForSystemNonSudoFirst() {
  funcName=$(getFunctionName)
  checkIfNotSudo $funcName
  if [ "${?}" = "0" ] ; then
    return
  fi;
  checkVirtualPythonEnvironmentFolder
  checkSoftwareFolder
  checkAppsFolder
  checkMusicVideosFolder
}

installPackagesForSystemSudoSecond() {
  funcName=$(getFunctionName)
  checkIfSudo $funcName
  if [ "${?}" = "0" ] ; then
    return
  fi;
  installPackagesForSystemSudo
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
}

downloadYoutubeVideo() {
  funcName=$(getFunctionName)
  if [ -z "$1" ]; then
    echo "null value not allowed as first parameter for method: \"${funcName}\"! You must pass the required parameter(s)."
    return $1
  fi;
  eval "cd $SYSTEM_MUSIC_VIDEOS_FOLDER"
  eval "youtube-dl https://www.youtube.com/watch\?v=$1"
}

alias android="sh $SYSTEM_APPS_FOLDER/android-studio/bin/studio.sh"
alias apache_reload='/etc/init.d/apache2 reload'
alias atom_up=apmUpdates
alias fb_d='firebase deploy'
alias fb_i='firebase init'
alias fb_l='firebase list'
alias fb_lo='firebase login'
alias fb_o='firebase open'
alias fb_s='firebase serve'
alias fb_v='firebase --version'
alias forever_list='forever list'
alias forever_restart='forever restart 0'
alias install_atom=installAtom
alias install_blender=installBlender
alias install_bracket="installBracket $LATEST_BRACKET_VERSION"
alias install_hack_lang=installHackLang
alias install_java=installJava
alias install_laravel=installLaravelNonSudo
alias install_mongo=installMongoDb
alias install_php=installPhp
alias install_postman=installPostman
alias install_pycharm="installPyCharm $LATEST_PYCHARM_VERSION"
alias install_python=installPython
alias install_python_postgres=installPythonAndPostgres
alias install_robo_mongo="installRoboMongo $LATEST_ROBOMONGO_VERSION $LATEST_ROBOMONGO_VERSION_FULL"
alias install_slack="installSlack $LATEST_SLACK_VERSION"
alias install_smartgit="installSmartgit $LATEST_SMARTGIT_FILE_NAME"
alias install_sublime="installSublime"
alias install_virtual_box=installVirtualBox
alias install_vscode="installVisualStudioCode $LATEST_VSCODE_FILE_NAME"
alias install_postman=installPostman
alias jenkins_install=installJenkins
alias jenkins_start='/etc/init.d/jenkins start'
alias jenkins_stop='/etc/init.d/jenkins stop'
alias karma_test='karma start --browsers Chrome'
alias loc_count='cloc '
alias node_update=nodeUpdates
alias pc="cd $SYSTEM_ROOT_FOLDER && sh $SYSTEM_APPS_FOLDER/$LATEST_PYCHARM_VERSION/bin/pycharm.sh"
alias protractor_test='protractor conf.js'
alias proxy_remove="kill -9 $(ps -efda | grep ssh | tail -n1 | awk '{print $2}')"
alias redis_check='redis-cli ping'
alias redis_start='nohup redis-server &'
alias redis_stop='redis-cli shutdown'
alias sg="cd $SYSTEM_ROOT_FOLDER && sh $SYSTEM_APPS_FOLDER/smartgit/bin/smartgit.sh"
alias ssh_agent_add='ssh-add ~/.ssh/id_rsa'
alias ssh_agent_add_root='ssh-add /root/.ssh/id_rsa'
alias ssh_agent_verify='eval "$(ssh-agent -s)"'
alias ssh_keygen='ssh-keygen -t rsa -b 4096 -C "$SYSTEM_USER_EMAIL"'
alias system_init_non_sudo_first=installPackagesForSystemNonSudoFirst
alias system_init_non_sudo_second=installPackagesForSystemNonSudoThird
alias system_init_sudo=installPackagesForSystemSudoSecond
alias ytd='downloadYoutubeVideo '
