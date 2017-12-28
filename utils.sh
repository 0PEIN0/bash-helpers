#!/bin/bash

apmUpdates() {
  funcName=$(getFunctionName)
  checkIfNotSudo $funcName
  if [ "${?}" = "0" ] ; then
    return
  fi;
  printf "yes\n" | apm update
  printf "yes\n" | apm upgrade
}

downloadYoutubeVideo() {
  funcName=$(getFunctionName)
  if [ -z "$1" ]; then
    echo "null value not allowed as first parameter for method: \"${funcName}\"! You must pass the required parameter(s)."
    return $1
  fi;
  eval "cd $SYSTEM_MUSIC_VIDEOS_FOLDER"
  eval "youtube-dl https://www.youtube.com/watch\?v=$1"
}

alias android="sh $SYSTEM_APPS_FOLDER/android-studio/bin/studio.sh"
alias apache_reload='/etc/init.d/apache2 reload'
alias atom_up=apmUpdates
alias fb_d='firebase deploy'
alias fb_i='firebase init'
alias fb_l='firebase list'
alias fb_lo='firebase login'
alias fb_o='firebase open'
alias fb_s='firebase serve'
alias fb_v='firebase --version'
alias forever_list='forever list'
alias forever_restart='forever restart 0'
alias jenkins_start='/etc/init.d/jenkins start'
alias jenkins_stop='/etc/init.d/jenkins stop'
alias karma_test='karma start --browsers Chrome'
alias loc_count='cloc '
alias pc="cd $SYSTEM_ROOT_FOLDER && sh $SYSTEM_APPS_FOLDER/$LATEST_PYCHARM_VERSION/bin/pycharm.sh"
alias protractor_test='protractor conf.js'
alias proxy_remove="kill -9 $(ps -efda | grep ssh | tail -n1 | awk '{print $2}')"
alias redis_check='redis-cli ping'
alias redis_start='nohup redis-server &'
alias redis_stop='redis-cli shutdown'
alias run_mono_develop='nohup flatpak run com.xamarin.MonoDevelop &'
alias sg="cd $SYSTEM_ROOT_FOLDER && sh $SYSTEM_APPS_FOLDER/smartgit/bin/smartgit.sh"
alias ytd='downloadYoutubeVideo '
