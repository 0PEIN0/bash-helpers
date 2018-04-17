installDocker() {
  funcName=$(getFunctionName)
  checkIfSudo $funcName
  if [ "${?}" = "0" ] ; then
    return
  fi;
  aptGet
  cd $SYSTEM_SOFTWARE_FOLDER/
  printf "y\n" | sudo apt-get remove docker docker-engine docker.io
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
  curl -sSL test.docker.com |sh
  usermod -aG docker ${USER}
  sudo adduser ${USER} docker
  sudo gpasswd -a ${USER} docker
  usermod -aG docker ${SYSTEM_USER_NAME}
  sudo adduser ${SYSTEM_USER_NAME} docker
  sudo gpasswd -a ${SYSTEM_USER_NAME} docker
  newgrp docker
  sudo service docker start
  goToRoot
}

alias docker_containers='docker container ls --all'
alias docker_images='docker image ls'
alias install_docker="installDocker"
