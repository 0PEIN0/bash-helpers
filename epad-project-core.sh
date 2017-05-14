#!/bin/bash

#REPLACE THESE ITEMS WHEN CREATING A NEW PROJECT FROM THIS FILE: 'EPAD_', 'epad_', 'epad'

EPAD_PYTHON_VERSION="2"
EPAD_REPO_NAME="epad"
EPAD_GIT_REPO="git@github.com:fvdoorn1970/$EPAD_REPO_NAME.git"
EPAD_PROJECT_NAME="epad"
EPAD_CELERY_PROJECT_NAME="epad"
EPAD_PROJECT_NAME_UNDERSCORE="epad"
EPAD_PROJECT_NAME_CAMEL_CASE="epad"
EPAD_LOCAL_PORT="8011"
EPAD_DJANGO_APP_NAMES="auths commons offers projects requirements cms emails payments sms questions_answers"
EPAD_POSTGRES_USER="postgres"
EPAD_CELERY_FLOWER_HOST="127.0.0.1"
EPAD_CELERY_FLOWER_PORT="5558"

EPAD_DJANGO_OPERATIONS="makemigrations migrate"
EPAD_INIT_REQUIREMENTS_FILE_NAME='requirements.txt'
EPAD_VIRTUAL_ENVIRONMENT_NAME="${EPAD_PROJECT_NAME_CAMEL_CASE}Env"
EPAD_PROJECT_ROOT_FOLDER="$SYSTEM_ROOT_GIT_REPO_FOLDER/$EPAD_REPO_NAME"
EPAD_INIT_DB_FILE_NAME="${EPAD_PROJECT_NAME}-reset-db.sql"
EPAD_POSTGRES_USER_PASSWORD_RESET_FILE_NAME="${EPAD_PROJECT_NAME}-postgres-password-reset.sql"
EPAD_INIT_DATA_LOAD_PYTHON_FILE_NAME="${EPAD_PROJECT_NAME_UNDERSCORE}_init_data_load.py"
EPAD_VIRTUAL_ENVIRONMENT_FOLDER="$SYSTEM_ROOT_VIRTUAL_PYTHON_ENVIRONMENT_FOLDER/$EPAD_VIRTUAL_ENVIRONMENT_NAME"
EPAD_INIT_POSTGRES_DB_FILE_PATH="$BASH_TEMP_FOLDER/$EPAD_INIT_DB_FILE_NAME"
EPAD_INIT_POSTGRES_DB_USER_PASSWORD_FILE_PATH="$BASH_TEMP_FOLDER/$EPAD_POSTGRES_USER_PASSWORD_RESET_FILE_NAME"
EPAD_INIT_DATA_LOAD_PYTHON_FILE_PATH="$BASH_TEMP_FOLDER/$EPAD_INIT_DATA_LOAD_PYTHON_FILE_NAME"

EPAD_DOCKER_ROOT_FOLDER="$EPAD_PROJECT_ROOT_FOLDER/docker"

if [ -f $BASH_TEMP_FOLDER/django-project-core.sh ]; then
    . $BASH_TEMP_FOLDER/django-project-core.sh
fi;

alias ${EPAD_PROJECT_NAME_UNDERSCORE}_bc="djangoBranchChange $EPAD_PROJECT_NAME_UNDERSCORE "
alias ${EPAD_PROJECT_NAME_UNDERSCORE}_bc_full_reset="djangoBranchChangeWithFullReset $EPAD_PROJECT_NAME_UNDERSCORE "
alias ${EPAD_PROJECT_NAME_UNDERSCORE}_bc_full_reset_and_run="djangoBranchChangeWithFullResetAndRun $EPAD_PROJECT_NAME_UNDERSCORE "
alias ${EPAD_PROJECT_NAME_UNDERSCORE}_bcd="${EPAD_PROJECT_NAME_UNDERSCORE}_bc develop"
alias ${EPAD_PROJECT_NAME_UNDERSCORE}_bcd_full_reset="${EPAD_PROJECT_NAME_UNDERSCORE}_bc_full_reset develop"
alias ${EPAD_PROJECT_NAME_UNDERSCORE}_bcd_full_reset_and_run="${EPAD_PROJECT_NAME_UNDERSCORE}_bc_full_reset_and_run develop"
alias ${EPAD_PROJECT_NAME_UNDERSCORE}_bcd_run="${EPAD_PROJECT_NAME_UNDERSCORE}_bcd && ${EPAD_PROJECT_NAME_UNDERSCORE}_run"
alias ${EPAD_PROJECT_NAME_UNDERSCORE}_db_shell="${EPAD_PROJECT_NAME_UNDERSCORE}_ve && ./manage.py shell"
alias ${EPAD_PROJECT_NAME_UNDERSCORE}_dir="goToDir \"$EPAD_PROJECT_ROOT_FOLDER\""
alias ${EPAD_PROJECT_NAME_UNDERSCORE}_frr="${EPAD_PROJECT_NAME_UNDERSCORE}_full_reset && ${EPAD_PROJECT_NAME_UNDERSCORE}_run"
alias ${EPAD_PROJECT_NAME_UNDERSCORE}_full_reset="djangoFullReset $EPAD_PROJECT_NAME_UNDERSCORE"
alias ${EPAD_PROJECT_NAME_UNDERSCORE}_gf="${EPAD_PROJECT_NAME_UNDERSCORE}_dir && git_f"
alias ${EPAD_PROJECT_NAME_UNDERSCORE}_git_setup="djangoGitSetup $EPAD_GIT_REPO"
alias ${EPAD_PROJECT_NAME_UNDERSCORE}_last_10_commit_hash="${EPAD_PROJECT_NAME_UNDERSCORE}_dir && git log -10 --pretty=format:\"%h\""
alias ${EPAD_PROJECT_NAME_UNDERSCORE}_loc="cloc \"$EPAD_PROJECT_ROOT_FOLDER\""
alias ${EPAD_PROJECT_NAME_UNDERSCORE}_reinitiate="djangoReinitiate \"$EPAD_PROJECT_ROOT_FOLDER\" \"$EPAD_DJANGO_APP_NAMES\" $EPAD_INIT_DATA_LOAD_PYTHON_FILE_PATH \"$EPAD_DJANGO_OPERATIONS\""
alias ${EPAD_PROJECT_NAME_UNDERSCORE}_reinitiate_clean="djangoReinitiateClean \"$EPAD_PROJECT_ROOT_FOLDER\" \"$EPAD_DJANGO_OPERATIONS\""
alias ${EPAD_PROJECT_NAME_UNDERSCORE}_postgres_shell="psql -U $EPAD_POSTGRES_USER"
alias ${EPAD_PROJECT_NAME_UNDERSCORE}_postgres_user_password_reset="postgresPasswordReset \"$EPAD_INIT_POSTGRES_DB_USER_PASSWORD_FILE_PATH\""
alias ${EPAD_PROJECT_NAME_UNDERSCORE}_process_id="lsof -i:${EPAD_LOCAL_PORT} | awk '{print $2}'"
alias ${EPAD_PROJECT_NAME_UNDERSCORE}_psql_reset="djangoPsqlReset $EPAD_POSTGRES_USER \"$EPAD_INIT_POSTGRES_DB_FILE_PATH\""
alias ${EPAD_PROJECT_NAME_UNDERSCORE}_reset="djangoReset $EPAD_PROJECT_NAME_UNDERSCORE"
alias ${EPAD_PROJECT_NAME_UNDERSCORE}_rr="${EPAD_PROJECT_NAME_UNDERSCORE}_reset && ${EPAD_PROJECT_NAME_UNDERSCORE}_run"
alias ${EPAD_PROJECT_NAME_UNDERSCORE}_rt="${EPAD_PROJECT_NAME_UNDERSCORE}_reset && ${EPAD_PROJECT_NAME_UNDERSCORE}_test"
alias ${EPAD_PROJECT_NAME_UNDERSCORE}_run="djangoRun $EPAD_PROJECT_NAME_UNDERSCORE $EPAD_PROJECT_NAME_UNDERSCORE $EPAD_LOCAL_PORT"
alias ${EPAD_PROJECT_NAME_UNDERSCORE}_run_production="djangoProductionRun $EPAD_PROJECT_NAME_UNDERSCORE $EPAD_PROJECT_NAME $EPAD_LOCAL_PORT"
alias ${EPAD_PROJECT_NAME_UNDERSCORE}_run_generic_deployment="djangoDeploymentOperations $EPAD_PROJECT_NAME_UNDERSCORE"
alias ${EPAD_PROJECT_NAME_UNDERSCORE}_start_celery="startCeleryWorkers $EPAD_CELERY_PROJECT_NAME $EPAD_CELERY_FLOWER_HOST $EPAD_CELERY_FLOWER_PORT"
alias ${EPAD_PROJECT_NAME_UNDERSCORE}_stop_processes="djangoStopProcesses $EPAD_LOCAL_PORT $EPAD_CELERY_PROJECT_NAME"
alias ${EPAD_PROJECT_NAME_UNDERSCORE}_test="djangoTest $EPAD_PROJECT_NAME_UNDERSCORE"
alias ${EPAD_PROJECT_NAME_UNDERSCORE}_ve="djangoUseVe \"$EPAD_VIRTUAL_ENVIRONMENT_FOLDER\" $EPAD_PROJECT_NAME_UNDERSCORE"
alias ${EPAD_PROJECT_NAME_UNDERSCORE}_ve_check="checkVirtualPythonEnvironmentFolder \"$EPAD_VIRTUAL_ENVIRONMENT_FOLDER\" \"$SYSTEM_ROOT_VIRTUAL_PYTHON_ENVIRONMENT_FOLDER\" $EPAD_VIRTUAL_ENVIRONMENT_NAME"
alias ${EPAD_PROJECT_NAME_UNDERSCORE}_ve_clear="djangoVeClear \"$SYSTEM_ROOT_VIRTUAL_PYTHON_ENVIRONMENT_FOLDER\" $EPAD_VIRTUAL_ENVIRONMENT_NAME"
alias ${EPAD_PROJECT_NAME_UNDERSCORE}_ve_init="pythonVeVersionDecider \"$EPAD_VIRTUAL_ENVIRONMENT_FOLDER\" \"$SYSTEM_ROOT_VIRTUAL_PYTHON_ENVIRONMENT_FOLDER\" $EPAD_VIRTUAL_ENVIRONMENT_NAME $EPAD_PROJECT_NAME \"$EPAD_PYTHON_VERSION\""
alias ${EPAD_PROJECT_NAME_UNDERSCORE}_ve_installs="djangoDefaultSetup \"$EPAD_PROJECT_ROOT_FOLDER\" $EPAD_INIT_REQUIREMENTS_FILE_NAME $EPAD_PROJECT_NAME_UNDERSCORE"
alias ${EPAD_PROJECT_NAME_UNDERSCORE}_installs="${EPAD_PROJECT_NAME_UNDERSCORE}_ve_init && cd \"$SYSTEM_ROOT_GIT_REPO_FOLDER\" && git clone ${EPAD_GIT_REPO} && ${EPAD_PROJECT_NAME_UNDERSCORE}_ve_installs && ${EPAD_PROJECT_NAME_UNDERSCORE}_dir"

epadBowerInstalls() {
  if [ -z "$1" ]; then
    echo 'null value not allowed as first parameter! You must pass the required parameter(s).'
    return $1
  fi;
  eval ${1}_ve
  eval ${1}_dir
  cd front_app/templates/
  bower update
  #TODO: decide if 'chai' is needed here
  #npm install --save-dev mocha
  npm install
  cd $EPAD_PROJECT_ROOT_FOLDER/
}

epadTestCoverage() {
  if [ -z "$1" ]; then
    echo 'null value not allowed as first parameter! You must pass the required parameter(s).'
    return $1
  fi;
  eval ${1}_ve
  eval ${1}_dir
  coverage erase
  printf "yes\n" | coverage run --omit="*/site-packages/*,*/external_resource.py,manage.py,epad/*,*/front_app/*,*/migrations/*,*/management/*" ./manage.py test
  coverage report
  coverage html -d cover
}

epadDockerInit() {
  if [ -z "$1" ]; then
    echo 'null value not allowed as first parameter! You must pass the required parameter(s).'
    return $1
  fi;
  eval ${1}_ve
  eval ${1}_dir
  make build-first
}

alias ${EPAD_PROJECT_NAME_UNDERSCORE}_bower_install="epadBowerInstalls"
alias ${EPAD_PROJECT_NAME_UNDERSCORE}_data_load='./manage.py data_load'
alias ${EPAD_PROJECT_NAME_UNDERSCORE}_data_sync='./manage.py download_fixtures'

alias ${EPAD_PROJECT_NAME_UNDERSCORE}_docker_compose_up="${EPAD_PROJECT_NAME_UNDERSCORE}_dir && cd docker/ && sudo docker-compose up"
alias ${EPAD_PROJECT_NAME_UNDERSCORE}_docker_build="${EPAD_PROJECT_NAME_UNDERSCORE}_dir && cp examples/local_settings.py . && cp examples/app.conf . && make remove-all && cd docker/ && make build-first"
alias ${EPAD_PROJECT_NAME_UNDERSCORE}_docker_init="epadDockerInit"
alias ${EPAD_PROJECT_NAME_UNDERSCORE}_docker_start="${EPAD_PROJECT_NAME_UNDERSCORE}_dir && cd docker/ && make start"
alias ${EPAD_PROJECT_NAME_UNDERSCORE}_docker_stop="${EPAD_PROJECT_NAME_UNDERSCORE}_dir && cd docker/ && make stop"
alias ${EPAD_PROJECT_NAME_UNDERSCORE}_docker_make="${EPAD_PROJECT_NAME_UNDERSCORE}_dir && cd docker/ && make "

alias ${EPAD_PROJECT_NAME_UNDERSCORE}_test_co=epadTestCoverage
alias ${EPAD_PROJECT_NAME_UNDERSCORE}_test_a="${EPAD_PROJECT_NAME_UNDERSCORE}_ve && printf \"yes\n\" | ./manage.py test auths.tests auths.rest_api.tests"
alias ${EPAD_PROJECT_NAME_UNDERSCORE}_test_cm="${EPAD_PROJECT_NAME_UNDERSCORE}_ve && printf \"yes\n\" | ./manage.py test cms.tests"
alias ${EPAD_PROJECT_NAME_UNDERSCORE}_test_o="${EPAD_PROJECT_NAME_UNDERSCORE}_ve && printf \"yes\n\" | ./manage.py test offers.tests offers.rest_api.tests"
alias ${EPAD_PROJECT_NAME_UNDERSCORE}_test_co="${EPAD_PROJECT_NAME_UNDERSCORE}_ve && printf \"yes\n\" | ./manage.py test commons.tests commons.rest_api.tests"
alias ${EPAD_PROJECT_NAME_UNDERSCORE}_test_r="${EPAD_PROJECT_NAME_UNDERSCORE}_ve && printf \"yes\n\" | ./manage.py test requirements.tests requirements.rest_api.tests"
alias ${EPAD_PROJECT_NAME_UNDERSCORE}_test_e="${EPAD_PROJECT_NAME_UNDERSCORE}_ve && printf \"yes\n\" | ./manage.py test emails.tests"
alias ${EPAD_PROJECT_NAME_UNDERSCORE}_test_pr="${EPAD_PROJECT_NAME_UNDERSCORE}_ve && printf \"yes\n\" | ./manage.py test projects.tests projects.rest_api.tests projects.testcases.test_hour_reg_service projects.testcases.test_issue_service projects.testcases.test_project_service"
alias ${EPAD_PROJECT_NAME_UNDERSCORE}_test_pa="${EPAD_PROJECT_NAME_UNDERSCORE}_ve && printf \"yes\n\" | ./manage.py test payments.tests"
alias ${EPAD_PROJECT_NAME_UNDERSCORE}_test_k="${EPAD_PROJECT_NAME_UNDERSCORE}_ve && cd front_app/templates && karma_test"
alias ${EPAD_PROJECT_NAME_UNDERSCORE}_coverage="openAUrlInBrowser file://$EPAD_PROJECT_ROOT_FOLDER/cover/index.html"

alias ${EPAD_PROJECT_NAME_UNDERSCORE}_dump_cms='./manage.py dumpdata cms --indent 4 --format json > ./cms/fixtures/cms.json'
alias ${EPAD_PROJECT_NAME_UNDERSCORE}_dump_commons='./manage.py dumpdata commons --indent 4 --format json > ./commons/fixtures/commons.json'
alias ${EPAD_PROJECT_NAME_UNDERSCORE}_dump_emails='./manage.py dumpdata emails --indent 4 --format json > ./emails/fixtures/emails.json'
