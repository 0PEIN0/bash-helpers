#!/bin/bash

#SYSTEM_USER_FULL_NAME="John Doe"
#SYSTEM_USER_EMAIL="john@doe.com"
#SYSTEM_USER_NAME="john"
SYSTEM_ROOT_FOLDER="/home/$SYSTEM_USER_NAME"
BASH_TEMP_FOLDER="$SYSTEM_ROOT_FOLDER/bash-dump"
SYSTEM_ROOT_GIT_REPO_FOLDER="$SYSTEM_ROOT_FOLDER/Gitrepos"
#BASH_HELPER_GIT_FOLDER="$SYSTEM_ROOT_GIT_REPO_FOLDER/bash-helpers"
BASH_HELPER_GIT_FOLDER="$BASH_TEMP_FOLDER"

if [ -f $BASH_HELPER_GIT_FOLDER/bash-core.sh ]; then
    . $BASH_HELPER_GIT_FOLDER/bash-core.sh
fi;

if [ -f $BASH_HELPER_GIT_FOLDER/drf-logger-project-team.sh ]; then
    . $BASH_HELPER_GIT_FOLDER/drf-logger-project-team.sh
fi;
