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
  sudo curl -L https://github.com/docker/compose/releases/download/$LATEST_DOCKER_COMPOSE_VERSION/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose
  sudo service docker start
  goToRoot
}

alias docker_containers='docker container ls --all'
alias docker_container_logs='docker logs '
alias docker_compose_build='docker-compose build'
alias docker_compose_up='docker-compose up'
alias docker_dangling_images="docker images --filter dangling=true -q"
alias docker_images='docker image ls'
alias docker_prune_all_containers='printf "y\n" | docker system prune -a'
alias docker_remove_all_images='docker rmi $(docker images -q)'
alias docker_prune_containers='printf "y\n" | docker container prune && docker_containers'
#alias docker_remove_containers='docker stop $(docker ps -aq)'#not working
alias docker_remove_dangling_images='docker rmi "$docker_dangling_images"'
alias docker_remove_image="docker rmi node "
alias docker_stop_containers='docker kill $(docker ps -q) && docker_containers'
alias docker_stop_prune_containers='docker_stop_containers && docker_prune_containers'
alias install_docker="installDocker"
