#!/bin/bash

installNodejs() {
  # Install NodeJS and NPM along with required global node modules
  aptGet
  curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
  sudo apt-get install -y nodejs
  nodeUpdates
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
  npm install -g @angular/cli
  npm install -g mongodb@latest
  npm install -g socket.io@latest
  npm install -g gulp gulp-cli@latest
  npm install -g bower@latest
  npm install -g mocha@latest
  npm install -g coffee-script@latest
  npm install -g karma-cli@latest
  npm install -g nodemon@latest
  npm install -g npm@latest
  npm install -g protractor@latest
  npm install -g firebase-tools@latest
  npm install -g pm2@latest
  npm install -g forever@latest
  npm install -g prettyjson@latest
  npm install -g uglify-js@latest
  npm install -g html-minifier@latest
  npm install -g react@latest
  npm install -g redux@latest
  npm install -g react-redux@latest
  npm install -g redux-devtools@latest
  npm install -g grunt-cli@latest
  npm install -g webpack@latest
  npm install -g cordova@latest
  npm install -g ionic@latest
  npm install -g electron@latest
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
