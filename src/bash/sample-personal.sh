#!/bin/bash

SYSTEM_USER_FULL_NAME="PLEASE_PROVIDE_YOUR_FULL_NAME"
SYSTEM_USER_EMAIL="PLEASE_PROVIDE_YOUR_EMAIL_THAT_IS_USED_IN_GIT_PROVIDERS"
SYSTEM_USER_NAME="PLEASE_PROVIDE_YOUR_UBUNTU_OS_USERNAME"
BASH_HELPER_GIT_FOLDER="/home/$SYSTEM_USER_NAME/Gitrepos/bash-helpers"

if [ -f $BASH_HELPER_GIT_FOLDER/src/bash/config.sh ]; then
    . $BASH_HELPER_GIT_FOLDER/src/bash/config.sh
fi;

DEFAULT_PERMISSION_VALUE=775
