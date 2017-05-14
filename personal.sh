#!/bin/bash

SYSTEM_USER_FULL_NAME="John Doe"
SYSTEM_USER_EMAIL="john@doe.com"
SYSTEM_USER_NAME="john"
BASH_TEMP_FOLDER="/home/$SYSTEM_USER_NAME/bash-dump"

if [ -f $BASH_TEMP_FOLDER/bash-core.sh ]; then
    . $BASH_TEMP_FOLDER/bash-core.sh
fi;

if [ -f $BASH_TEMP_FOLDER/fleks-project-team.sh ]; then
    . $BASH_TEMP_FOLDER/fleks-project-team.sh
fi;

if [ -f $BASH_TEMP_FOLDER/epad-project-team.sh ]; then
    . $BASH_TEMP_FOLDER/epad-project-team.sh
fi;
