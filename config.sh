#!/bin/bash

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

if [ -f $BASH_HELPER_GIT_FOLDER/nodejs.sh ]; then
    . $BASH_HELPER_GIT_FOLDER/nodejs.sh
fi;
