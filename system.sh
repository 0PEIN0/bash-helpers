#!/bin/bash

SYSTEM_ROOT_FOLDER="/home/$SYSTEM_USER_NAME"
BASH_TEMP_FOLDER="$SYSTEM_ROOT_FOLDER/helper-scripts"
SYSTEM_ROOT_GIT_REPO_FOLDER="$SYSTEM_ROOT_FOLDER/Gitrepos"
SYSTEM_DOWNLOAD_FOLDER="$SYSTEM_ROOT_FOLDER/Downloads"
SYSTEM_SOFTWARE_FOLDER="$SYSTEM_DOWNLOAD_FOLDER/Softwares"
SYSTEM_APPS_FOLDER="$SYSTEM_ROOT_FOLDER/Apps"
SYSTEM_MUSIC_VIDEOS_FOLDER="$SYSTEM_ROOT_FOLDER/Music\ Videos"
BASH_HELPER_GIT_FOLDER="$SYSTEM_ROOT_GIT_REPO_FOLDER/bash-helpers"
DEFAULT_PERMISSION_VALUE=640

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
  source ~/.bash_aliases
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
      echo "aaanull value not allowed as ${parameterPositions[i]} parameter for method: \"${2}\"! You must pass the required parameter(s)."
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
  funcName=$(getFunctionName)
  checkIfNotSudo $funcName
  if [ "${?}" = "0" ] ; then
    return
  fi;
  goToRoot
  if [ -d "$SYSTEM_ROOT_VIRTUAL_PYTHON_ENVIRONMENT_FOLDER" ]; then
    cd $SYSTEM_ROOT_VIRTUAL_PYTHON_ENVIRONMENT_FOLDER/
  else
    cd $SYSTEM_ROOT_FOLDER/
    mkdir -p $SYSTEM_ROOT_VIRTUAL_PYTHON_ENVIRONMENT_FOLDER_NAME
    cd $SYSTEM_ROOT_VIRTUAL_PYTHON_ENVIRONMENT_FOLDER_NAME/
  fi;
}

checkSoftwareFolder() {
  funcName=$(getFunctionName)
  checkIfNotSudo $funcName
  if [ "${?}" = "0" ] ; then
    return
  fi;
  goToRoot
  downloadFolder="$SYSTEM_DOWNLOAD_FOLDER"
  if [ ! -d "$downloadFolder" ]; then
    mkdir -p $downloadFolder
    chmod $DEFAULT_PERMISSION_VALUE $downloadFolder
  fi;
  cd $downloadFolder/
  softwareFolder="$SYSTEM_SOFTWARE_FOLDER"
  if [ ! -d "$softwareFolder" ]; then
    mkdir -p $softwareFolder
    chmod $DEFAULT_PERMISSION_VALUE $softwareFolder
  fi;
  cd $softwareFolder/
}

checkAppsFolder() {
  funcName=$(getFunctionName)
  checkIfNotSudo $funcName
  if [ "${?}" = "0" ] ; then
    return
  fi;
  goToRoot
  appsFolder="$SYSTEM_APPS_FOLDER/"
  if [ ! -d "$appsFolder" ]; then
    mkdir -p $appsFolder
    chmod $DEFAULT_PERMISSION_VALUE $appsFolder
  fi;
  cd $appsFolder/
}

checkMusicVideosFolder() {
  funcName=$(getFunctionName)
  checkIfNotSudo $funcName
  if [ "${?}" = "0" ] ; then
    return
  fi;
  goToRoot
  musicVideosFolder="$SYSTEM_MUSIC_VIDEOS_FOLDER/"
  if [ ! -d "$musicVideosFolder" ]; then
    mkdir -p $musicVideosFolder
    chmod $DEFAULT_PERMISSION_VALUE $musicVideosFolder
  fi;
  cd $musicVideosFolder/
}

rcFactoryReset() {
  funcName=$(getFunctionName)
  checkIfSudo $funcName
  if [ "${?}" = "0" ] ; then
    return
  fi;
  /bin/cp /etc/skel/.bashrc $SYSTEM_ROOT_FOLDER/
}

changePermissionOfBashrcFiles() {
  funcName=$(getFunctionName)
  checkIfSudo $funcName
  if [ "${?}" = "0" ] ; then
    return
  fi;
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

systemUpdatesNonSudo() {
  funcName=$(getFunctionName)
  checkIfNotSudo $funcName
  if [ "${?}" = "0" ] ; then
    return
  fi;
  cd /
  bash_refresh
  upgrade_oh_my_zsh
  youtube-dl -U
  apmUpdates
  eval "sshOperationsNonSudo"
  cd $BASH_HELPER_GIT_FOLDER
  eval "gitResetHard"
  eval "git_f"
  eval "gitResetHard"
  cd /
}

systemUpdatesSudo() {
  funcName=$(getFunctionName)
  checkIfSudo $funcName
  if [ "${?}" = "0" ] ; then
    return
  fi;
  cd /
  bash_refresh
  coreSystemUpdate
  upgrade_oh_my_zsh
  youtube-dl -U
  nodeUpdates
  pip_update
  cd /
}

alias admin='sudo su'
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
alias fperm='stat -c "%a %n" '
alias gbrc='gedit ~/.bashrc'
alias gerc='gedit /etc/bash.bashrc'
alias get_ssh='cat ~/.ssh/id_rsa.pub | xclip -sel clip'
alias gzrc='gedit ~/.zshrc'
alias home='cd ~/'
alias last_shutdown='last -x | grep shutdown'
alias no_sudo_zsh='export SHELL=/usr/bin/zsh && exec /usr/bin/zsh -l'
alias proxy_remove="kill -9 $(ps -efda | grep ssh | tail -n1 | awk '{print $2}')"
alias rc_factory_reset=rcFactoryReset
alias root='goToRoot'
alias service_details='systemctl status '
alias ssh_agent_add='ssh-add ~/.ssh/id_rsa'
alias ssh_agent_add_root='ssh-add /root/.ssh/id_rsa'
alias ssh_agent_verify='eval "$(ssh-agent -s)"'
alias ssh_keygen='ssh-keygen -t rsa -b 4096 -C "$SYSTEM_USER_EMAIL"'
alias ssh_non_sudo_setup=sshOperationsNonSudo
alias ssh_sudo_setup=sshOperationsSudo
alias tar_install='tar -xzf '
alias uap=systemUpdatesNonSudo
alias uar=systemUpdatesSudo
alias up='cd ..'
alias zrc='~/.zshrc'
