#!/bin/bash

installNodejs() {
  # Install NodeJS
  aptGet
  printf 'y\n' | sudo apt-get remove nodejs
  sudo rm -rf /usr/lib/node_modules/
  sudo rm -rf /usr/local/lib/node_modules/
  curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
  sudo apt-get install -y nodejs
  sudo apt-get install -y npm
}

installVueJs() {
  funcName=$(getFunctionName)
  checkIfSudo $funcName
  if [ "${?}" = "0" ] ; then
    return
  fi;
  goToRoot
  npm uninstall -g vue-cli
  npm install -g @vue/cli
  npm install -g @vue/cli-init
}

installAngular() {
  funcName=$(getFunctionName)
  checkIfSudo $funcName
  if [ "${?}" = "0" ] ; then
    return
  fi;
  goToRoot
  npm install -g @angular/cli
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
  npm install -g bower@latest
  npm install -g coffeescript@latest
  npm install -g cordova@latest
  npm install -g create-react-app@latest
  npm install -g electron@latest --unsafe-perm=true --allow-root
  npm install -g firebase-tools@latest
  npm install -g forever@latest
  npm install -g grunt-cli@latest
  npm install -g gulp gulp-cli@latest
  npm install -g http-server@latest
  npm install -g ionic@latest
  npm install -g karma-cli@latest
  npm install -g mongodb@latest
  npm install -g newman@latest
  npm install -g nodemon@latest
  npm install -g npm@latest
  npm install -g protractor@latest
  npm install -g pm2@latest
  npm install -g prettyjson@latest
  npm install -g redux-devtools@latest
  npm install -g webpack@latest
  npm install -g webpack-dev-server@latest
  installVueJs
  webdriver-manager update
  goToRoot
}

nodeExpressNpmInitiation() {
  funcName=$(getFunctionName)
  checkIfNotSudo $funcName
  if [ "${?}" = "0" ] ; then
    return
  fi;
  npm install async@latest --save
  npm install bluebird@latest --save
  npm install body-parser@latest --save
  npm install chai@latest --save-dev
  npm install concurrently@latest --save-dev
  npm install connect-mongo@latest --save
  npm install cookie-parser@latest --save
  npm install cookie-session@latest --save
  npm install compression@latest --save
  npm install connect@latest --save
  npm install cron@latest --save
  npm install csurf@latest --save
  npm install dotenv@latest --save
  npm install errorhandler@latest --save
  npm install express@latest --save
  npm install express-session@latest --save
  npm install express-validator@latest --save
  npm install file-stream-rotator@latest --save
  npm install helmet@latest --save
  npm install html-minifier@latest --save
  npm install jest@latest --save-dev
  npm install lodash@latest --save
  npm install method-override@latest --save
  npm install multer@latest --save
  npm install mongoose@latest --save
  npm install morgan@latest --save
  npm install nodemailer@latest --save
  npm install nodemon@latest --save-dev
  npm install passport@latest --save
  npm install passport-local@latest --save
  npm install pug@latest --save
  npm install raven@latest --save
  npm install request@latest --save
  npm install request-promise@latest --save
  npm install response-time@latest --save
  npm install serve-favicon@latest --save
  npm install serve-index@latest --save
  npm install serve-static@latest --save
  npm install shelljs@latest --save
  npm install supertest@latest --save-dev
  npm install vhost@latest --save
  npm install winston@latest --save
}

nodeExpressNpmInitiationTypeScript() {
  funcName=$(getFunctionName)
  checkIfNotSudo $funcName
  if [ "${?}" = "0" ] ; then
    return
  fi;
  nodeExpressNpmInitiation
  npm install @types/async@latest --save-dev
  npm install @types/bluebird@latest --save-dev
  npm install @types/body-parser@latest --save-dev
  npm install @types/chai@latest --save-dev
  npm install @types/concurrently@latest --save-dev
  npm install @types/connect-mongo@latest --save-dev
  npm install @types/cookie-parser@latest --save-dev
  npm install @types/cookie-session@latest --save-dev
  npm install @types/compression@latest --save-dev
  npm install @types/connect@latest --save-dev
  npm install @types/cron@latest --save-dev
  npm install @types/csurf@latest --save-dev
  npm install @types/dotenv@latest --save-dev
  npm install @types/errorhandler@latest --save-dev
  npm install @types/express@latest --save-dev
  npm install @types/express-session@latest --save-dev
  npm install @types/express-validator@latest --save-dev
  npm install @types/file-stream-rotator@latest --save-dev
  npm install @types/helmet@latest --save-dev
  npm install @types/html-minifier@latest --save-dev
  npm install @types/jest@latest --save-dev
  npm install @types/lodash@latest --save-dev
  npm install @types/method-override@latest --save-dev
  npm install @types/multer@latest --save-dev
  npm install @types/mongoose@latest --save-dev
  npm install @types/morgan@latest --save-dev
  npm install @types/nodemailer@latest --save-dev
  npm install @types/nodemon@latest --save-dev
  npm install @types/passport@latest --save-dev
  npm install @types/passport-local@latest --save-dev
  npm install @types/pug@latest --save-dev
  npm install @types/raven@latest --save-dev
  npm install @types/request@latest --save-dev
  npm install @types/request-promise@latest --save-dev
  npm install @types/response-time@latest --save-dev
  npm install @types/serve-favicon@latest --save-dev
  npm install @types/serve-index@latest --save-dev
  npm install @types/serve-static@latest --save-dev
  npm install @types/shelljs@latest --save-dev
  npm install @types/supertest@latest --save-dev
  npm install @types/vhost@latest --save-dev
  npm install @types/winston@latest --save-dev
  npm install ts-jest@latest --save-dev
  npm install ts-node@latest --save-dev
  npm install tslint@latest --save-dev
  npm install typescript@latest --save-dev

}

alias node_update=nodeUpdates
alias install_angular=installAngular
alias install_nodejs=installNodejs
alias install_vuejs=installVueJs
alias node_express_new_app=nodeExpressNpmInitiation
alias node_express_new_app_ts=nodeExpressNpmInitiationTypeScript
alias npm_adduser="npm adduser" # asks for username, password and public-email in the prompt
alias npm_build="npm run build"
alias npm_i="npm install"
alias npm_publish="npm publish" # don't forget to upgrade the version before publishing
alias npm_update="npm update"
alias npm_update_watch="npm_update && npm_watch"
alias npm_watch="npm_build && npm run start"
alias npm_whoami="npm whoami"
