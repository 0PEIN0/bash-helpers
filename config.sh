#!/bin/bash

SYSTEM_ROOT_FOLDER="/home/your-username/your-folder"
BASH_TEMP_FOLDER="$SYSTEM_ROOT_FOLDER/bash-dump"
SYSTEM_ROOT_GIT_REPO_FOLDER="$SYSTEM_ROOT_FOLDER/Gitrepos"
BASH_HELPER_GIT_FOLDER="$SYSTEM_ROOT_GIT_REPO_FOLDER/bash-helpers"


SYSTEM_USER_FULL_NAME="Your Full Name"
SYSTEM_USER_EMAIL="your-username@example.com"
SYSTEM_USER_NAME="your-username"

SYSTEM_ROOT_VIRTUAL_PYTHON_ENVIRONMENT_FOLDER="$SYSTEM_ROOT_FOLDER/$SYSTEM_ROOT_VIRTUAL_PYTHON_ENVIRONMENT_FOLDER_NAME"
BASH_HELPER_GIT_FOLDER="/home/$SYSTEM_USER_NAME/Gitrepos/$PEIN_FRAMEWORK_PROECT_NAME/Ubuntu/library"
DEFAULT_PERMISSION_VALUE=777

if [ -f $BASH_HELPER_GIT_FOLDER/system.sh ]; then
    . $BASH_HELPER_GIT_FOLDER/system.sh
fi;

if [ -f $BASH_HELPER_GIT_FOLDER/git.sh ]; then
    . $BASH_HELPER_GIT_FOLDER/git.sh
fi;

if [ -f $BASH_HELPER_GIT_FOLDER/install.sh ]; then
    . $BASH_HELPER_GIT_FOLDER/install.sh
fi;

if [ -f $BASH_HELPER_GIT_FOLDER/django.sh ]; then
    . $BASH_HELPER_GIT_FOLDER/django.sh
fi;

if [ -f $BASH_HELPER_GIT_FOLDER/example.sh ]; then
    . $BASH_HELPER_GIT_FOLDER/example.sh
fi;
