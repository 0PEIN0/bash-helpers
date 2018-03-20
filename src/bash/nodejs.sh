#!/bin/bash

installNodejs() {
  # Install NodeJS
  aptGet
  printf 'y\n' | sudo apt-get remove nodejs
  sudo rm -rf /usr/lib/node_modules/
  sudo rm -rf /usr/local/lib/node_modules/
  curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
  sudo apt-get install -y nodejs
}

nodeUpdates() {
  funcName=$(getFunctionName)
  checkIfSudo $funcName
  if [ "${?}" = "0" ] ; then
    return
  fi;
  aptGet
  goToRoot
  npm i -g npm
  #npm install -g @angular/cli
  npm install -g mongodb@latest
  npm install -g gulp gulp-cli@latest
  npm install -g bower@latest
  npm install -g coffeescript@latest
  npm install -g karma-cli@latest
  npm install -g nodemon@latest
  npm install -g npm@latest
  npm install -g protractor@latest
  npm install -g firebase-tools@latest
  npm install -g pm2@latest
  npm install -g forever@latest
  npm install -g prettyjson@latest
  npm install -g create-react-app@latest
  npm install -g redux-devtools@latest
  npm install -g grunt-cli@latest
  npm install -g webpack@latest
  npm install -g webpack-dev-server@latest
  npm install -g vue-cli@latest
  npm install -g cordova@latest
  npm install -g ionic@latest
  npm install -g newman@latest
  npm install -g electron@latest --unsafe-perm=true --allow-root
  npm install -g http-server@latest
  webdriver-manager update
  goToRoot
}

nodeExpressNpmInitiation() {
  funcName=$(getFunctionName)
  checkIfSudo $funcName
  if [ "${?}" = "0" ] ; then
    return
  fi;
  npm install express@latest --save
  npm install body-parser@latest --save
  npm install cookie-parser@latest --save
  npm install multer@latest --save
  npm install nodemailer@latest --save
  npm install file-stream-rotator@latest --save
  npm install morgan@latest --save
  npm install connect@latest --save
  npm install body-parser@latest --save
  npm install compression@latest --save
  npm install cookie-parser@latest --save
  npm install cookie-session@latest --save
  npm install csurf@latest --save
  npm install errorhandler@latest --save
  npm install express-session@latest --save
  npm install method-override@latest --save
  npm install response-time@latest --save
  npm install serve-favicon@latest --save
  npm install serve-index@latest --save
  npm install serve-static@latest --save
  npm install vhost@latest --save
  npm install pm2@latest --save
  npm install forever@latest --save
  npm install winston@latest --save
  npm install raven@latest --save
  npm install helmet@latest --save
  npm install cron@latest --save
  npm install uglify-js@latest --save
  npm install html-minifier@latest --save
}

alias node_update=nodeUpdates
alias install_nodejs=installNodejs
alias npm_adduser="npm adduser" # asks for username, password and public-email in the prompt
alias npm_build="npm run build"
alias npm_i="npm install"
alias npm_publish="npm publish" # don't forget to upgrade the version before publishing
alias npm_update="npm update"
alias npm_update_watch="npm_update && npm_watch"
alias npm_watch="npm_build && npm run start"
alias npm_whoami="npm whoami"
