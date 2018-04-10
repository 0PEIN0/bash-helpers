1. Open the "Powershell" application in "Administrator" Mode
2. Type this and hit enter: "Set-ExecutionPolicy AllSigned" or 'bypass' instead of 'AllSiggned'.
3. Do this: http://stackoverflow.com/a/24914795/623810 and use $PsHome directory.
4. Browse to this(where the script files are located) directory.
5. "chocolaty-installation.bat" batch script file must be present in the current directory. This script file will executed inside the "cordova-environment-initiation.ps1" powershell script.
6. Run "cordova-environment-initiation.ps1" powershell script file from powershell by entering ". .\cordova-environment-initiation.ps1" in powershell command line and pressing "enter" key.
7. Open "cordova-app-initiation.bat" batch script file with a text editor and change the "appName" variable value located at the file line of the script. This value should be the name of your cordova/phonegap application.
8. Then goto a directory where you would like to store your cordova application. Copy and paste the "cordova-app-initiation.bat" file there and run it there from powershell command line. Run "cordova-app-initiation.bat" batch script file from the powershell command line by entering ". .\cordova-app-initiation.bat" and pressing "enter" key.
