set appName=msb-test

if exist %appName% (echo Y | rd /s %appName%)

call cordova create %appName% com.desme.phonegap.app %appName%

cd %appName%

call cordova platform add android

call cordova plugin add org.apache.cordova.device@latest
call cordova plugin add org.apache.cordova.network-information@latest
call cordova plugin add org.apache.cordova.battery-status@latest
call cordova plugin add org.apache.cordova.device-motion@latest
call cordova plugin add org.apache.cordova.device-orientation@latest
call cordova plugin add org.apache.cordova.geolocation@latest
call cordova plugin add org.apache.cordova.camera@latest
call cordova plugin add org.apache.cordova.media-capture@latest
call cordova plugin add org.apache.cordova.media@latest
call cordova plugin add org.apache.cordova.file@latest
call cordova plugin add org.apache.cordova.file-transfer@latest
call cordova plugin add org.apache.cordova.dialogs@latest
call cordova plugin add org.apache.cordova.vibration@latest
call cordova plugin add org.apache.cordova.contacts@latest
call cordova plugin add org.apache.cordova.globalization@latest
call cordova plugin add org.apache.cordova.splashscreen@latest
call cordova plugin add org.apache.cordova.inappbrowser@latest
call cordova plugin add org.apache.cordova.console@latest

echo "Project Creation Complete!"

pause
