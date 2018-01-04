#!/bin/bash

if [ -f $BASH_HELPER_GIT_FOLDER/src/bash/system.sh ]; then
    . $BASH_HELPER_GIT_FOLDER/src/bash/system.sh
fi;

if [ -f $BASH_HELPER_GIT_FOLDER/src/bash/git.sh ]; then
    . $BASH_HELPER_GIT_FOLDER/src/bash/git.sh
fi;

if [ -f $BASH_HELPER_GIT_FOLDER/src/bash/install.sh ]; then
    . $BASH_HELPER_GIT_FOLDER/src/bash/install.sh
fi;

if [ -f $BASH_HELPER_GIT_FOLDER/src/bash/utils.sh ]; then
    . $BASH_HELPER_GIT_FOLDER/src/bash/utils.sh
fi;

if [ -f $BASH_HELPER_GIT_FOLDER/src/bash/django.sh ]; then
    . $BASH_HELPER_GIT_FOLDER/src/bash/django.sh
fi;

if [ -f $BASH_HELPER_GIT_FOLDER/src/bash/nodejs.sh ]; then
    . $BASH_HELPER_GIT_FOLDER/src/bash/nodejs.sh
fi;
