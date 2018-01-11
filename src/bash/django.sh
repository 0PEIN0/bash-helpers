#!/bin/bash

SYSTEM_ROOT_VIRTUAL_PYTHON_ENVIRONMENT_FOLDER_NAME="virtual-python-envs"
SYSTEM_ROOT_VIRTUAL_PYTHON_ENVIRONMENT_FOLDER="$SYSTEM_ROOT_FOLDER/$SYSTEM_ROOT_VIRTUAL_PYTHON_ENVIRONMENT_FOLDER_NAME"

postgresPgpassFileInit() {
  funcName=$(getFunctionName)
  checkIfNotSudo $funcName
  if [ "${?}" = "0" ] ; then
    return
  fi;
  if [ ! -f ~/.pgpass ]; then
    touch $USER:$USER ~/.pgpass
  fi;
  chown $USER:$USER ~/.pgpass
  chmod $DEFAULT_PERMISSION_VALUE ~/.pgpass
  echo -e "localhost:5432:*:postgres:$SYSTEM_USER_NAME\n127.0.0.1:5432:*:postgres:$SYSTEM_USER_NAME\n">~/.pgpass
  echo "Updated pgpass file"
}

newDjangoProject() {
  funcName=$(getFunctionName)
  if [ -z "$1" ]; then
    echo "null value not allowed as first parameter for method: \"${funcName}\"! You must pass the required parameter(s)."
    return $1
  fi;
  django-admin startproject $1 .
}

checkVirtualPythonEnvironmentFolder() {
  if [ -z "$1" ]; then
    echo 'null value not allowed as first parameter! You must pass the required parameter(s).'
    return $1
  fi;
  if [ -z "$2" ]; then
    echo 'null value not allowed as second parameter! You must pass the required parameter(s).'
    return $2
  fi;
  if [ -z "$3" ]; then
    echo 'null value not allowed as third parameter! You must pass the required parameter(s).'
    return $3
  fi;
  goToRoot
  if [ -d "$1" ]; then
    cd $1/
  else
    cd $2/
    mkdir -p $3
    cd $3/
  fi;
}

postgresPasswordReset() {
  if [ -z "$1" ]; then
    echo 'null value not allowed as first parameter! You must pass the required parameter(s).'
    return $1
  fi;
  goToRoot
  sudo -u postgres psql < $1
  sudo service postgresql restart
}

pythonThreeVeCheck() {
  if [ -z "$1" ]; then
    echo 'null value not allowed as first parameter! You must pass the required parameter(s).'
    return $1
  fi;
  if [ -z "$2" ]; then
    echo 'null value not allowed as second parameter! You must pass the required parameter(s).'
    return $2
  fi;
  if [ -z "$3" ]; then
    echo 'null value not allowed as third parameter! You must pass the required parameter(s).'
    return $3
  fi;
  if [ -z "$4" ]; then
    echo 'null value not allowed as fourth parameter! You must pass the required parameter(s).'
    return $4
  fi;
  if [ -d "$1/bin" ]; then
    cd $1/
    echo "VE exists for $4!"
  else
    cd $2/
    virtualenv -p python3.5 $3
    echo "Created VE for $4!"
  fi;
}

pythonTwoVeCheck() {
  if [ -z "$1" ]; then
    echo 'null value not allowed as first parameter! You must pass the required parameter(s).'
    return $1
  fi;
  if [ -z "$2" ]; then
    echo 'null value not allowed as second parameter! You must pass the required parameter(s).'
    return $2
  fi;
  if [ -z "$3" ]; then
    echo 'null value not allowed as third parameter! You must pass the required parameter(s).'
    return $3
  fi;
  if [ -z "$4" ]; then
    echo 'null value not allowed as fourth parameter! You must pass the required parameter(s).'
    return $4
  fi;
  if [ -d "$1/bin" ]; then
    cd $1/
    echo "VE exists for $4!"
  else
    cd $2/
    virtualenv -p python2 $3
    echo "Created VE for $4!"
  fi;
}

pythonVeVersionDecider() {
  if [ -z "$1" ]; then
    echo 'null value not allowed as first parameter! You must pass the required parameter(s).'
    return $1
  fi;
  if [ -z "$2" ]; then
    echo 'null value not allowed as second parameter! You must pass the required parameter(s).'
    return $2
  fi;
  if [ -z "$3" ]; then
    echo 'null value not allowed as third parameter! You must pass the required parameter(s).'
    return $3
  fi;
  if [ -z "$4" ]; then
    echo 'null value not allowed as fourth parameter! You must pass the required parameter(s).'
    return $4
  fi;
  if [ -z "$5" ]; then
    echo 'null value not allowed as fifth parameter! You must pass the required parameter(s).'
    return $5
  fi;
  if [ "$5" = "2" ]; then
    eval 'pythonTwoVeCheck "${1}" "${2}" "${3}" "${4}"'
  elif [ "$5" = "3" ]; then
    eval 'pythonThreeVeCheck "${1}" "${2}" "${3}" "${4}"'
  else
    echo "Invalid parameter passed for python version."
  fi;
}

djangoUseVe() {
  if [ -z "$1" ]; then
    echo 'null value not allowed as first parameter! You must pass the required parameter(s).'
    return $1
  fi;
  if [ -z "$2" ]; then
    echo 'null value not allowed as second parameter! You must pass the required parameter(s).'
    return $2
  fi;
  eval ${2}_ve_check
  cd $1/
  source bin/activate
  eval ${2}_dir
}

startCeleryWorkers() {
  if [ -z "$1" ]; then
    echo 'null value not allowed as first parameter! You must pass the required parameter(s).'
    return $1
  fi;
  if [ -z "$2" ]; then
    echo 'null value not allowed as second parameter! You must pass the required parameter(s).'
    return $2
  fi;
  if [ -z "$3" ]; then
    echo 'null value not allowed as third parameter! You must pass the required parameter(s).'
    return $3
  fi;
  nohup celery -A $1 worker -l info &
  nohup celery -A $1 beat -l info -S django &
  nohup celery flower -A $1 --address=$2 --port=$3 &
}

djangoStopProcesses() {
  if [ -z "$1" ]; then
    echo 'null value not allowed as first parameter! You must pass the required parameter(s).'
    return $1
  fi;
  if [ -z "$2" ]; then
    echo 'null value not allowed as second parameter! You must pass the required parameter(s).'
    return $2
  fi;
  kill -9 $(lsof -t -i:$1)
  kill $(ps aux | grep python | grep manage.py | awk '{print $2}')
  celery multi stop celery --pidfile=celerybeat.pid
  #celery multi stop worker
  celery multi stop $2
  celery multi stop flower
  celery multi stop beat
  celery -A $2 purge -f
  #ps auxww | grep 'celery worker' | awk '{print $2}' | xargs kill -9
  ps auxww | grep 'beat' | awk '{print $2}' | xargs kill -9
  ps auxww | grep 'flower' | awk '{print $2}' | xargs kill -9
  #the following command crashes chrome
  #ps auxww | grep 'worker' | awk '{print $2}' | xargs kill -9
  ps auxww | grep 'celery' | awk '{print $2}' | xargs kill -9
  #ps auxww | grep 'nohup' | awk '{print $2}' | xargs kill -9
  ps auxww | grep "$2" | awk '{print $2}' | xargs kill -9
  pgrep -f celery | xargs kill -9
}

djangoVeClear() {
  if [ -z "$1" ]; then
    echo 'null value not allowed as first parameter! You must pass the required parameter(s).'
    return $1
  fi;
  if [ -z "$2" ]; then
    echo 'null value not allowed as second parameter! You must pass the required parameter(s).'
    return $2
  fi;
  cd $1/
  virtualenv --clear $2
  rm -rf $2
}

djangoGitSetup() {
  if [ -z "$1" ]; then
  echo 'null value not allowed as first parameter! You must pass the required parameter(s).'
    return $1
  fi;
  git remote set-url origin $1
}

djangoDefaultSetup() {
  if [ -z "$1" ]; then
    echo 'null value not allowed as first parameter! You must pass the required parameter(s).'
    return $1
  fi;
  if [ -z "$2" ]; then
    echo 'null value not allowed as second parameter! You must pass the required parameter(s).'
    return $2
  fi;
  if [ -z "$3" ]; then
    echo 'null value not allowed as third parameter! You must pass the required parameter(s).'
    return $3
  fi;
  cd $1/
  eval ${3}_ve
  eval "pip install -r $1/$2"
  eval ${3}_dir
}

djangoPsqlReset() {
  if [ -z "$1" ]; then
    echo 'null value not allowed as first parameter! You must pass the required parameter(s).'
    return $1
  fi;
  if [ -z "$2" ]; then
    echo 'null value not allowed as second parameter! You must pass the required parameter(s).'
    return $2
  fi;
  chmod 600 ~/.pgpass
  psql -U $1 -h localhost -f $2 $1
}

djangoProjectDataLoad() {
  if [ -z "$1" ]; then
    echo 'null value not allowed as first parameter! You must pass the required parameter(s).'
    return $1
  fi;
  if [ -z "$2" ]; then
    echo 'null value not allowed as second parameter! You must pass the required parameter(s).'
    return $2
  fi;
  goToRoot
  cd $1/
  printf "y\n" | pip uninstall ipython
  ./manage.py shell < $2
  pip install ipython
}

djangoReinitiate() {
  if [ -z "$1" ]; then
    echo 'null value not allowed as first parameter! You must pass the required parameter(s).'
    return $1
  fi;
  if [ -z "$2" ]; then
    echo 'null value not allowed as second parameter! You must pass the required parameter(s).'
    return $2
  fi;
  if [ -z "$3" ]; then
    echo 'null value not allowed as third parameter! You must pass the required parameter(s).'
    return $3
  fi;
  if [ -z "$4" ]; then
    echo 'null value not allowed as fourth parameter! You must pass the required parameter(s).'
    return $4
  fi;
  goToRoot
  cd $1/
  rm -rf $1/*/migrations/
  setopt rmstarsilent
  printf "y\n" | rm -rf uploads/*
  find . -name '*.pyc' -delete
  appNames=("${2}")
  if [ $SHELL = "/usr/bin/zsh" ]; then
    appNames=(${(s: :)2})
  fi;
  for i in ${appNames[@]}; do
    mkdir -p $1/$i/migrations/
    touch $1/$i/migrations/__init__.py
  done
  operations=("${4}")
  if [ $SHELL = "/usr/bin/zsh" ]; then
    operations=(${(s: :)4})
  fi;
  for i in ${operations[@]}; do
    ./manage.py $i
  done
  djangoProjectDataLoad $1 $3
}

djangoReinitiateClean() {
  if [ -z "$1" ]; then
    echo 'null value not allowed as first parameter! You must pass the required parameter(s).'
    return $1
  fi;
  if [ -z "$2" ]; then
    echo 'null value not allowed as second parameter! You must pass the required parameter(s).'
    return $2
  fi;
  goToRoot
  cd $1/
  operations=("${2}")
  if [ $SHELL = "/usr/bin/zsh" ]; then
    operations=(${(s: :)2})
  fi;
  for i in ${operations[@]}; do
    ./manage.py $i
  done
}

djangoReset() {
  if [ -z "$1" ]; then
    echo 'null value not allowed as first parameter! You must pass the required parameter(s).'
    return $1
  fi;
  eval ${1}_stop_processes
  eval ${1}_dir
  eval ${1}_ve_check
  eval ${1}_ve_installs
  eval ${1}_reinitiate_clean
  bashRefresh
  eval ${1}_ve
}

djangoFullReset() {
  if [ -z "$1" ]; then
    echo 'null value not allowed as first parameter! You must pass the required parameter(s).'
    return $1
  fi;
  goToRoot
  eval ${1}_ve
  eval ${1}_stop_processes
  eval ${1}_ve_clear
  eval ${1}_ve_init
  eval ${1}_ve_installs
  eval ${1}_psql_reset
  eval ${1}_reinitiate
  bashRefresh
  eval ${1}_ve
}

djangoTest() {
  if [ -z "$1" ]; then
    echo 'null value not allowed as first parameter! You must pass the required parameter(s).'
    return $1
  fi;
  eval ${1}_ve
  find . -name '*.pyc' -delete
  printf "yes\n" | ./manage.py test
}

djangoBranchChange() {
  if [ -z "$1" ]; then
    echo 'null value not allowed as first parameter! You must pass the required parameter(s).'
    return $1
  fi;
  if [ -z "$2" ]; then
    echo 'null value not allowed as second parameter! You must pass the required parameter(s).'
    return $2
  fi;
  eval ${1}_stop_processes
  eval ${1}_dir
  eval ${1}_git_setup
  gitCheckout $2
  gitResetHard
  eval ${1}_ve_check
  eval ${1}_ve_installs
  eval ${1}_reinitiate_clean
  bashRefresh
  eval ${1}_ve
}

djangoBranchChangeRun() {
  djangoBranchChange $1 $2
  eval ${1}_run
}

djangoBranchChangeWithFullReset() {
  if [ -z "$1" ]; then
    echo 'null value not allowed as first parameter! You must pass the required parameter(s).'
    return $1
  fi;
  if [ -z "$2" ]; then
    echo 'null value not allowed as second parameter! You must pass the required parameter(s).'
    return $2
  fi;
  eval ${1}_stop_processes
  eval ${1}_dir
  eval ${1}_git_setup
  gitCheckout $2
  gitResetHard
  eval ${1}_ve
  eval ${1}_ve_clear
  eval ${1}_ve_init
  eval ${1}_ve_installs
  eval ${1}_psql_reset
  eval ${1}_reinitiate
  bashRefresh
  eval ${1}_ve
}

djangoRun() {
  if [ -z "$1" ]; then
    echo 'null value not allowed as first parameter! You must pass the required parameter(s).'
    return $1
  fi;
  if [ -z "$2" ]; then
    echo 'null value not allowed as second parameter! You must pass the required parameter(s).'
    return $2
  fi;
  if [ -z "$3" ]; then
    echo 'null value not allowed as third parameter! You must pass the required parameter(s).'
    return $3
  fi;
  bashRefresh
  eval ${1}_ve
  eval ${1}_stop_processes
  eval ${1}_start_celery
  ./manage.py runserver 0.0.0.0:${3}
  echo "$2 Project Server Running!"
}

djangoProductionRun() {
  if [ -z "$1" ]; then
    echo 'null value not allowed as first parameter! You must pass the required parameter(s).'
    return $1
  fi;
  if [ -z "$2" ]; then
    echo 'null value not allowed as second parameter! You must pass the required parameter(s).'
    return $2
  fi;
  if [ -z "$3" ]; then
    echo 'null value not allowed as third parameter! You must pass the required parameter(s).'
    return $3
  fi;
  bashRefresh
  eval ${1}_ve
  eval ${1}_stop_processes
  eval ${1}_start_celery
  nohup ./manage.py runserver 0.0.0.0:${3} &
  echo "$2 Project Server Running!"
}

djangoDeploymentOperations() {
  if [ -z "$1" ]; then
    echo 'null value not allowed as first parameter! You must pass the required parameter(s).'
    return $1
  fi;
  goToRoot
  eval ${1}_ve
  eval ${1}_stop_processes
  eval "$(ssh-agent -s)"
  ssh-add ~/.ssh/id_rsa
}

djangoBranchChangeWithFullResetAndRun() {
  if [ -z "$1" ]; then
    echo 'null value not allowed as first parameter! You must pass the required parameter(s).'
    return $1
  fi;
  if [ -z "$2" ]; then
    echo 'null value not allowed as second parameter! You must pass the required parameter(s).'
    return $2
  fi;
  eval ${1}_bc_full_reset $2
  eval ${1}_run
}

djangoResetWithoutMigrationClean() {
  if [ -z "$1" ]; then
    echo 'null value not allowed as first parameter! You must pass the required parameter(s).'
    return $1
  fi;
  if [ -z "$2" ]; then
    echo 'null value not allowed as second parameter! You must pass the required parameter(s).'
    return $2
  fi;
  goToRoot
  eval ${1}_ve
  eval ${1}_psql_reset
  ./manage.py makemigrations
  ./manage.py migrate
  ./manage.py shell < $2
}

djangoMakeMigrations() {
  if [ -z "$1" ]; then
    echo 'null value not allowed as first parameter! You must pass the required parameter(s).'
    return $1
  fi;
  eval ${1}_ve
  eval "./manage.py makemigrations"
}

djangoMigrate() {
  if [ -z "$1" ]; then
    echo 'null value not allowed as first parameter! You must pass the required parameter(s).'
    return $1
  fi;
  eval ${1}_ve
  eval "./manage.py migrate"
}

rabbitMqRestart() {
  funcName=$(getFunctionName)
  checkIfSudo $funcName
  if [ "${?}" = "0" ] ; then
    return
  fi;
  rabbitmqctl status
  rabbitmqctl stop
  rabbitmq-plugins enable rabbitmq_management
  sudo invoke-rc.d rabbitmq-server start
  rabbitmqctl status
}

alias new_django_project=newDjangoProject
alias new_django_app='./manage.py startapp '
alias pip_freeze='pip freeze > requirements.txt'
alias pip_init='pip install django django-celery-beat psycopg2 djangorestframework markdown python-magic django-filter dj-database-url raven whitenoise django-nose nose gunicorn pytz mock django-celery django-celery-results ipython flower django-material && pip_freeze'
alias pip_update='pip install --upgrade pip'
alias postgres_pgpass_file=postgresPgpassFileInit
alias postgres_restart='sudo service postgresql restart'
alias postgres_shell='psql -U postgres'
alias postgres_shell_sudo='sudo -u postgres psql'
alias python_postgres_init='install_python_postgres && postgres_pgpass_file && postgres_restart'
