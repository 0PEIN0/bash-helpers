
goToRoot() {
  cd /
}

goToDir() {
  if [ -z "$1" ]; then
    echo 'null value not allowed as first parameter! You must pass the required parameter(s).'
    return $1
  fi;
  cd $1/
}

clearTerminal() {
  clear
  printf "\033c"
  tput reset
  cat /dev/null > ~/.bash_history
}

bashRefresh() {
  # source ~/.bash_aliases
  source ~/.zshrc
}

isSudoMode() {
  if [ "$EUID" -ne 0 ] ; then
    echo "0"
    return
  else
    echo "1"
    return
  fi;
}

isFile() {
  if [ -z "$1" ]; then
    echo "null value not allowed as first parameter for method: \"${funcName}\"! You must pass the required parameter(s)."
    return $1
  fi;
  if [ ! -f "$1" ]; then
    return 0
  else
    return 1
  fi;
}

isDir() {
  if [ -z "$1" ]; then
    echo "null value not allowed as first parameter for method: \"${funcName}\"! You must pass the required parameter(s)."
    return $1
  fi;
  if [ -d "$1" ]; then
    return 1
  else
    return 2
  fi;
}

isZsh() {
  if [ $SHELL = "/usr/bin/zsh" ]; then
    return 1
  else
    return 0
  fi;
}

getFunctionName() {
  isZsh
  res=$?
  funcName=""
  if [ "$res" = "1" ] ; then
    funcName=$funcstack[2]
  else
    funcName=${FUNCNAME[1]}
  fi;
  echo $funcName
}

checkIfSudo() {
  if [ -z "$1" ]; then
    echo "null value not allowed as first parameter for method: \"checkIfSudo\"! You must pass the required parameter(s)."
    return "0"
  fi;
  sudoMode=$(isSudoMode)
  if [ "$sudoMode" = "0" ] ; then
    echo "Have to use sudo mode for this method: \"${1}\"."
    return "0"
  fi;
  return "1"
}

checkIfNotSudo() {
  if [ -z "$1" ]; then
    echo "null value not allowed as first parameter for method: \"checkIfNotSudo\"! You must pass the required parameter(s)."
    return "0"
  fi;
  sudoMode=$(isSudoMode)
  if [ "$sudoMode" = "1" ] ; then
    echo "Can not use sudo mode for this method: \"${1}\"."
    return "0"
  fi;
  echo ""
  return "1"
}

checkParameters() {
  if [ -z "$1" ]; then
    echo "null value not allowed as first parameter for method: \"checkParameters\"! You must pass the required parameter(s)."
    return "0"
  fi;
  if [ -z "$2" ]; then
    echo "null value not allowed as second parameter for method: \"checkParameters\"! You must pass the required parameter(s)."
    return "0"
  fi;
  parameterPositions=(first second third fourth fifth sixth seventh eighth ninth tenth)
  for i in {1..${1}}
  do
    j=$((i+2))
    #echo $i $j "${\"$j\"}"
    if [ -z "$j" ]; then
      echo "null value not allowed as ${parameterPositions[i]} parameter for method: \"${2}\"! You must pass the required parameter(s)."
      return "0"
    fi;
  done
  return "1"
}

aptGet() {
  funcName=$(getFunctionName)
  checkIfSudo $funcName
  if [ "${?}" = "0" ] ; then
    return
  fi;
  sudo apt-get update --fix-missing
  sudo dpkg --configure -a
  sudo apt-get update --fix-missing
}

aptGetUpgrade() {
  funcName=$(getFunctionName)
  checkIfSudo $funcName
  if [ "${?}" = "0" ] ; then
    return
  fi;
  aptGet
  printf "y\ny\n" | sudo apt-get upgrade
}

coreSystemUpdate() {
  funcName=$(getFunctionName)
  checkIfSudo $funcName
  if [ "${?}" = "0" ] ; then
    return
  fi;
  aptGet
  printf "y\ny\n" | sudo apt-get upgrade
  aptGet
  printf "y\n" | sudo apt-get dist-upgrade
  aptGet
  printf "y\n" | sudo apt autoremove
  aptGet
}

checkVirtualPythonEnvironmentFolder() {
  goToRoot
  if [ -d "$SYSTEM_ROOT_VIRTUAL_PYTHON_ENVIRONMENT_FOLDER" ]; then
    cd $SYSTEM_ROOT_VIRTUAL_PYTHON_ENVIRONMENT_FOLDER/
  else
    cd $SYSTEM_ROOT_FOLDER/
    mkdir $SYSTEM_ROOT_VIRTUAL_PYTHON_ENVIRONMENT_FOLDER_NAME
    cd $SYSTEM_ROOT_VIRTUAL_PYTHON_ENVIRONMENT_FOLDER_NAME/
  fi;
}

checkSoftwareFolder() {
  goToRoot
  downloadFolder="$SYSTEM_DOWNLOAD_FOLDER"
  if [ ! -d "$downloadFolder" ]; then
    mkdir $downloadFolder
    chmod $DEFAULT_PERMISSION_VALUE $downloadFolder
  fi;
  cd $downloadFolder/
  softwareFolder="$SYSTEM_SOFTWARE_FOLDER"
  if [ ! -d "$softwareFolder" ]; then
    mkdir $softwareFolder
    chmod $DEFAULT_PERMISSION_VALUE $softwareFolder
  fi;
  cd $softwareFolder/
}

checkAppsFolder() {
  goToRoot
  appsFolder="$SYSTEM_APPS_FOLDER/"
  if [ ! -d "$appsFolder" ]; then
    mkdir $appsFolder
    chmod $DEFAULT_PERMISSION_VALUE $appsFolder
  fi;
  cd $appsFolder/
}
rcFactoryReset() {
  /bin/cp /etc/skel/.bashrc $SYSTEM_ROOT_FOLDER/
}

changePermissionOfBashrcFiles() {
  chmod $DEFAULT_PERMISSION_VALUE $SYSTEM_ROOT_FOLDER/.zshrc
  chmod $DEFAULT_PERMISSION_VALUE $SYSTEM_ROOT_FOLDER/.bashrc
  chmod $DEFAULT_PERMISSION_VALUE /etc/bash.bashrc
}

openAUrlInBrowser() {
  funcName=$(getFunctionName)
  if [ -z "$1" ]; then
    echo "null value not allowed as first parameter for method: \"${funcName}\"! You must pass the required parameter(s)."
    return $1
  fi;
  if which xdg-open > /dev/null
  then
    xdg-open $1
  elif which gnome-open > /dev/null
  then
    gnome-open $1
  fi;
}

getWebsiteData() {
  funcName=$(getFunctionName)
  if [ -z "$1" ]; then
    echo "null value not allowed as first parameter for method: \"${funcName}\"! You must pass the required parameter(s)."
    return $1
  fi;
  echo `curl $1`
}

findStringPattern() {
  funcName=$(getFunctionName)
  if [ -z "$1" ]; then
    echo "null value not allowed as first parameter for method: \"${funcName}\"! You must pass the required parameter(s)."
    return $1
  fi;
  if [ -z "$2" ]; then
    echo "null value not allowed as second parameter for method: \"${funcName}\"! You must pass the required parameter(s)."
    return $2
  fi;
  dataString=$1
  dataStringLen=${#dataString}
  startPartternString=$2
  startPartternStringLen=${#startPartternString}
}

sshOperationsSudo() {
  funcName=$(getFunctionName)
  checkIfSudo $funcName
  if [ "${?}" = "0" ] ; then
    return
  fi;
  ssh_agent_verify
  ssh_agent_add_root
  github_keyscan_sudo
  bitbucket_keyscan_sudo
  github_auth
  bitbucket_auth
}

sshOperationsNonSudo() {
  funcName=$(getFunctionName)
  checkIfNotSudo $funcName
  if [ "${?}" = "0" ] ; then
    return
  fi;
  ssh_agent_verify
  ssh_agent_add
  github_keyscan_non_sudo
  bitbucket_keyscan_non_sudo
  github_auth
  bitbucket_auth
}



alias admin='sudo -i'
alias allow_port_sudo='sudo ufw allow '
alias apache_reload='/etc/init.d/apache2 reload'
alias apt_get=aptGetUpgrade
alias bash_refresh=bashRefresh
alias brc='~/.bashrc'
alias check_ubuntu_version='lsb_release -a'
alias cls='clearTerminal'
alias cls_root='clearTerminal && goToRoot'
alias downloads="cd $SYSTEM_DOWNLOAD_FOLDER"
alias erc='/etc/bash.bashrc'
alias firewall_list='sudo ufw app list'
alias filewall_status="sudo ufw status"
alias forever_list='forever list'
alias forever_restart='forever restart 0'
alias fperm='stat -c "%a %n" '
alias gbrc='gedit ~/.bashrc'
alias gerc='gedit /etc/bash.bashrc'
alias get_ssh='cat ~/.ssh/id_rsa.pub | xclip -sel clip'
alias gpg_config='git config --global gpg.program gpg2'
alias gpg_export='gpg --armor --export'
alias gpg_gen='gpg --gen-key'
alias gpg_list='gpg --list-secret-keys --keyid-format LONG'
alias gpg_sign='git config --global user.signingkey'
alias gzrc='gedit ~/.zshrc'
alias home='cd ~/'
alias loc_count='cloc '
alias no_sudo_zsh='export SHELL=/usr/bin/zsh && exec /usr/bin/zsh -l'
alias pc="cd $SYSTEM_ROOT_FOLDER && sh $SYSTEM_APPS_FOLDER/$LATEST_PYCHARM_VERSION/bin/pycharm.sh"
alias protractor_test='protractor conf.js'
alias proxy_remove="kill -9 $(ps -efda | grep ssh | tail -n1 | awk '{print $2}')"
alias rc_factory_reset=rcFactoryReset
alias root='goToRoot'
alias service_details='systemctl status '
alias tar_install='tar -xzf '
alias up='cd ..'
alias zrc='~/.zshrc'
