# bash-helpers
Bash helper scripts.

Intended to help software engineers working on python/django environment.

# Usage instructions:

### LOGIN TO THE SYSTEM FOR THE FIRST TIME AND IN NON SUDO MODE
1. Open "Firefox" -> Visit "https://www.google.com/chrome/browser/desktop/index.html" -> Download the 64-bit deb file and install Chrome.
2. Open "Chrome" -> Visit "https://www.dropbox.com/install-linux" -> Download the 64-bit deb file and install Dropbox.
3. Login to Chrome as user.
4. Create "bash-dump" folder in the user directory. Path will look like this: "/home/$SYSTEM_USER_NAME/bash-dump/".
5. Open "Chrome" -> Visit "https://raw.githubusercontent.com/0PEIN0/bash-helpers/develop/bash-core.sh" and save the file in bash-dump folder.
6. Open "Chrome" -> Visit "https://raw.githubusercontent.com/0PEIN0/bash-helpers/develop/personal.sh" and save the file in bash-dump folder.
7. Open the "personal.sh" file located in the bash-dump folder and change the following variable values and un-comment the code there. And comment out the last 3 imports there and replace the placeholder values with relevant values.
`SYSTEM_USER_FULL_NAME="John Doe"`
`SYSTEM_USER_EMAIL="john@doe.com"`
`SYSTEM_USER_NAME="john"`
8. Open "System Settings" -> "Power" -> Select "Do nothing" for both of the options named as "When lid is closed".
9. Open "System Settings" -> "Brightness & Lock" -> Unselect "Dim screen to save power".
10. Open "System Settings" -> "Brightness & Lock" -> Select "Never" for "Turn screen off when inactive for".
11. Open "System Settings" -> "Time & Date" -> "Clock" -> Select "Weekday" and "Date", Month", "Year", "Seconds" and "Include week numbers".
12. Open "System Settings" -> "Software and Updates" -> "Ubuntu Software" -> Select "Main Server" for "Download From" option.
13. Open "System Settings" -> "Software and Updates" -> "Additional Drivers" -> Select "Using NVIDIA binary driver" for allowing proprietary software from NVIDIA to be installed on the machine in case NVIDIA graphics card is present -> Press "Apply Changes" button.
14. Open "System Settings" -> "Language Support" -> Drag "English(United States)" at the top of the order.
15. Open "System Settings" -> "Language Support" -> "Regional Formats" -> Select "English(United States)" -> Press "Apply System Wide" button.
16. Restart machine.

### IN NON SUDO MODE
1. Run `gedit ~/.bash_aliases` from command line (add the reference to personal bash file).
2. Below is the sample example for import of personal shell file.
```bash
if [ -f /home/$SYSTEM_USER_NAME/bash-dump/personal.sh ]; then
    . /home/$SYSTEM_USER_NAME/bash-dump/personal.sh
fi;
```
3. Run `system_init_non_sudo_first` command.
4. Run `admin` command(enter into the sudo mode).

### SWITCH TO SUDO MODE
1. Run `gedit ~/.bash_aliases` from command line (add the reference to personal bash file).
2. Run `system_init_sudo` command.
3. Restart machine.
4. Enter sudo mode again by running `admin` command.
5. Run `gedit ~/.zshrc` (change the zsh theme to "agnoster", or any of your preferred theme, and add the reference to personal bash file as well located in bash-dump folder).
6. Do the following postgres operation after replacing ***"$SYSTEM_USER_NAME*** value.
```sql
sudo -u postgres psql -c 'CREATE EXTENSION IF NOT EXISTS postgis; CREATE EXTENSION IF NOT EXISTS postgis_topology; ALTER USER postgres PASSWORD '$SYSTEM_USER_NAME'; ALTER role postgres PASSWORD '$SYSTEM_USER_NAME'; CREATE ROLE $SYSTEM_USER_NAME LOGIN PASSWORD '$SYSTEM_USER_NAME';CREATE USER $SYSTEM_USER_NAME WITH PASSWORD '$SYSTEM_USER_NAME'; alter ROLE $SYSTEM_USER_NAME LOGIN PASSWORD '$SYSTEM_USER_NAME';alter USER $SYSTEM_USER_NAME WITH PASSWORD '$SYSTEM_USER_NAME';ALTER ROLE $SYSTEM_USER_NAME SET client_encoding TO 'utf8'; ALTER ROLE $SYSTEM_USER_NAME SET default_transaction_isolation TO 'read committed' ;ALTER ROLE $SYSTEM_USER_NAME SET timezone TO 'UTC';alter role $SYSTEM_USER_NAME superuser;'
```
7. Run `ssh_keygen` command.
8. Run `get_ssh` command.
9. Add the ssh public key at Github and Bitbucket.
10. Run `ssh_sudo_setup` comamnd.

### SWITCH BACK TO NON SUDO MODE, THAT IS YOUR PERSONAL SYSTEM USER
1. Run `system_init_non_sudo_second` command.
2. Run `gedit ~/.zshrc` (change the zsh theme to "agnoster", or any of your preferred theme, and add the reference to personal bash file as well located in bash-dump folder).
3. Run `ssh_keygen` command.
4. Run `get_ssh` command.
5. Add the ssh public key at Github and Bitbucket.
6. Run `ssh_non_sudo_setup` command.
7. Run `admin` command.

### SWITCH BACK TO SUDO MODE
1. Download smartgit, vscode, pycharm deb files and put them in the **/home/$SYSTEM_USER_NAME/Downloads/Softwares** folder. Change the 3 app versions from below at the top of the `bash-core.sh` file with the latest version of the respective softwares. Namely ***$LATEST_SMARTGIT_FILE_NAME***, ***$LATEST_VSCODE_FILE_NAME***, ***$LATEST_PYCHARM_VERSION*** variable values. Then run `install_smartgit`, `install_vscode`, `install_pycharm`.

>1. http://www.syntevo.com/smartgit/download
>2. https://code.visualstudio.com/download
>3. https://www.jetbrains.com/pycharm/download/

2. Install JAVA by running this following command: `install_java`. Choose "Ok" and "Yes" for the prompts.
3. Open "Terminal" and run this command to install all the global packages via npm: `node_update`.
4. Restart machine.

### SWITCH TO NON SUDO MODE, THAT IS YOUR PERSONAL SYSTEM USER
1. Open "Tweak Tool" -> "Appearance" -> "Icons" -> Select "Ultra-Flat_orange".
2. Open "Tweak Tool" -> "Power" -> "When laptop lid is closed" -> "On Battery Power" -> Select "Nothing".
3. Open "Tweak Tool" -> "Power" -> "When laptop lid is closed" -> "When plugged in" -> Select "Nothing".
4. Open "Tweak Tool" -> "Power" -> "When laptop lid is closed" -> "Don't suspend on lid close" -> Select "No".
5. Open "Tweak Tool" -> "Startup Applications" -> Add applications like "Google Chrome", "Atom", "Terminal", "System Monitor", "Files", "Dropbox", "Slack", "Sublime Text", "VLC Media Player", "Smartgit", "Skype".
6. Open "Unity Tweak Tool" -> "Unity" -> "Launcher" -> "Appearance" -> "Position" -> Select "Bottom".
7. Open "Unity Tweak Tool" -> "Unity" -> "Launcher" -> "Icons" -> "Icon Size" -> Make it "32".
8. Open "Unity Tweak Tool" -> "Unity" -> "Panel" -> "Indicators" -> Select "Show my name".
9. Open "Unity Tweak Tool" -> "Unity" -> "Panel" -> "Indicators" -> Select "Power" -> "Always visible".
10. Open "Unity Tweak Tool" -> "Unity" -> "Panel" -> "Indicators" -> "Default Player" -> Select "Vlc.desktop".
11. Open "Chrome" -> Visit "https://slack.com/downloads/linux" -> Download the 64 bit slack and install using Ubuntu package manager.
12. Open "Dropbox" from dash -> Login to Dropbox.
13. Open "Terminal" and install Steam by running this command: "sudo apt-get install steam". Open "Steam" and login.
14. Clone the https://github.com/0PEIN0/bash-helpers repository to make sure the latest updates can be pulled at any time. Also update the bash imports in the machine for both sudo and non-sudo users.
15. Make ".txt", ".md", ".py", ".js", ".html", ".sh", ".css" file open default application to "Sublime".
16. Make ".mkv", ".mp4", ".webm" file open default application to "VLC Player".
17. Restart machine.
18. Open "Terminal" -> "Edit" menu -> "Profile Preferences" -> "Text Appearance" -> "Custom Font" -> "Choose A Terminal Font" -> Select "Meslo LG L DZ for Powerline Bold" -> Make font size "16".
19. Open "Atom" -> There will be a pop-up showing list of dependencies to install, press "Yes" to install them.
