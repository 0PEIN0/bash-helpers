# Bash Helpers
Bash helper scripts.

Intended to help software engineers working on python/django and nodejs environment. The scripts that were used below are only tested on **Ubuntu 16.04 LTS**. There will be no OS version specific package changes on the script until **Ubuntu 18.04 LTS** release. We will need to wait a few months after release to get all the packages for 18.04 version.

>Legends:

1. `bash-helpers` is the name of the repository and the folder name where this repository is cloned.
2. `helper-scripts` is that place where you place your `personal.sh` bash files as well as your other scripts that are meant to customize your local machine  environment.

# New System Installation Instructions

### LOGIN TO THE SYSTEM FOR THE FIRST TIME AND IN NON SUDO USER MODE
1. Open "Firefox" -> Visit "https://www.google.com/chrome/browser/desktop/index.html" -> Download the 64-bit deb file and install Chrome.
2. Open "Chrome" -> Visit "https://www.dropbox.com/install-linux" -> Download the 64-bit deb file and install Dropbox.
3. Login to Chrome as user.
4. Create ***Gitrepos*** folder in the user directory. Path will look like this: **/home/$SYSTEM_USER_NAME/Gitrepos/**. Here ***$SYSTEM_USER_NAME*** denotes the user name of the operating system(Ubuntu in this case) user, which is not the default ***root*** user.
5. Open "Chrome" and go to [Bash Helper's Repository](https://github.com/0PEIN0/bash-helpers) and clone it in Gitrepos folder by running following commands:
```sh
$ cd /home/$SYSTEM_USER_NAME/Gitrepos/
$ git clone https://github.com/0PEIN0/bash-helpers.git
```
Here ***$SYSTEM_USER_NAME*** denotes the user name of the operating system(Ubuntu in this case) user, which is not the default ***root*** user.
6. After cloning, create a new directory again inside of user directory. Path will look like this: **/home/$SYSTEM_USER_NAME/helper-scripts/**. Here ***$SYSTEM_USER_NAME*** denotes the user name of the operating system(Ubuntu in this case) user, which is not the default ***root*** user. After you have created this folder, create a new file there(inside the newly created folder) called ***personal.sh***. Copy the file contents from ***sample-personal.sh*** file from the current repository to ***/home/$SYSTEM_USER_NAME/helper-scripts/personal.sh*** file. Then just configure your info in ***personal.sh*** file like this:

>`SYSTEM_USER_FULL_NAME="John Doe"`

>`SYSTEM_USER_EMAIL="john@example.com"`

>`SYSTEM_USER_NAME="john"`

7. Open ***~/.bash_aliases*** file and add the import of the **/home/$SYSTEM_USER_NAME/helper-scripts/personal.sh** file there. Then source it. Run `gedit ~/.bash_aliases` from command line to open up the file.
8. Below is a sample example for import of personal bash file in ***~/.bash_aliases*** file. Remember to replace the ***$SYSTEM_USER_NAME*** string here with actual operating system username.
```bash
if [ -f /home/$SYSTEM_USER_NAME/helper-scripts/personal.sh ]; then
    . /home/$SYSTEM_USER_NAME/helper-scripts/personal.sh
fi;
```
9. Run `source ~/.bashrc` command.
10. Run `system_init_non_sudo_first` command.
11. Run `admin` command(enter into the sudo user mode).

### SWITCH TO SUDO USER MODE
1. Open ***~/.bash_aliases*** file and add the import of the **/home/$SYSTEM_USER_NAME/helper-scripts/personal.sh** file there. Then source it. Run `gedit ~/.bash_aliases` from command line to open up the file.
2. Below is a sample example for import of personal bash file in ***~/.bash_aliases*** file. Remember to replace the ***$SYSTEM_USER_NAME*** string here with actual operating system username.
```bash
if [ -f /home/$SYSTEM_USER_NAME/helper-scripts/personal.sh ]; then
    . /home/$SYSTEM_USER_NAME/helper-scripts/personal.sh
fi;
```
3. Run `source ~/.bashrc` command.
4. Run `system_init_sudo` command. This command will take approximately 2 hours, have a snack/coffee in this period.
5. Restart machine.
6. Enter sudo user mode again after restart by running `admin` command.
7. Run `gedit ~/.zshrc` (change the zsh theme to "agnoster", or any of your preferred theme, and add the reference to personal bash file as well located in bash-dump folder).
8. Do the following postgres operation after replacing ***"$SYSTEM_USER_NAME*** value.
```sql
'ALTER USER postgres PASSWORD "$SYSTEM_USER_NAME"; ALTER role postgres PASSWORD "$SYSTEM_USER_NAME"; CREATE ROLE $SYSTEM_USER_NAME LOGIN PASSWORD "$SYSTEM_USER_NAME";CREATE USER $SYSTEM_USER_NAME WITH PASSWORD "$SYSTEM_USER_NAME"; alter ROLE $SYSTEM_USER_NAME LOGIN PASSWORD "$SYSTEM_USER_NAME";alter USER $SYSTEM_USER_NAME WITH PASSWORD "$SYSTEM_USER_NAME";ALTER ROLE $SYSTEM_USER_NAME SET client_encoding TO "utf8"; ALTER ROLE $SYSTEM_USER_NAME SET default_transaction_isolation TO "read committed" ;ALTER ROLE $SYSTEM_USER_NAME SET timezone TO "UTC";alter role $SYSTEM_USER_NAME superuser;CREATE EXTENSION postgis;CREATE EXTENSION postgis_topology;CREATE EXTENSION postgis_sfcgal;CREATE EXTENSION fuzzystrmatch;CREATE EXTENSION address_standardizer;CREATE EXTENSION address_standardizer_data_us;CREATE EXTENSION postgis_tiger_geocoder;'
```
Its also possible to run the above sql queries directly from command line as well, like the following.
```bash
sudo -u postgres psql -c '<SQL_QUERY>'
```
9. Run `ssh_keygen` command.
10. Run `get_ssh` command.
11. Add the ssh public key at Github and Bitbucket.
12. Run `ssh_sudo_setup` command.
13. Open "Terminal" and run this command to install all the necessary global packages via npm: `node_update`.
14. Run `exit` command.

### SWITCH BACK TO NON SUDO USER MODE, THAT IS YOUR PERSONAL SYSTEM USER
1. Run `system_init_non_sudo_second` command.
2. Run `gedit ~/.zshrc` (change the zsh theme to "agnoster", or any of your preferred theme, and add the reference to personal bash file as well located in bash-dump folder).
3. Run `source ~/.zshrc`.
4. Run `ssh_keygen` command.
5. Run `get_ssh` command.
6. Add the ssh public key at Github and Bitbucket.
7. Run `ssh_non_sudo_setup` command.
8. Open "Atom" -> There will be a pop-up showing list of dependencies to install, press "Yes" to install them.
9. Open "Dropbox" from dash -> Login to Dropbox.
10. Open "Terminal" and install Steam by running this command: `sudo apt-get install steam`. Open ***Steam*** and login.
11. Open "Tweak Tool" -> "Appearance" -> "Icons" -> Select "Ultra-Flat_orange".
12. Open "Tweak Tool" -> "Power" -> "When laptop lid is closed" -> "On Battery Power" -> Select "Nothing".
13. Open "Tweak Tool" -> "Power" -> "When laptop lid is closed" -> "When plugged in" -> Select "Nothing".
14. Open "Tweak Tool" -> "Power" -> "When laptop lid is closed" -> "Don't suspend on lid close" -> Select "No".
15.  Open "Tweak Tool" -> "Startup Applications" -> Add applications like "Google Chrome", "Atom", "Terminal", "System Monitor", "Files", "Dropbox", "Slack", "Sublime Text", "VLC Media Player", "Smartgit", "Skype", "Spotify".
16. Open "Unity Tweak Tool" -> "Unity" -> "Launcher" -> "Appearance" -> "Position" -> Select "Bottom".
17. Open "Unity Tweak Tool" -> "Unity" -> "Launcher" -> "Icons" -> "Icon Size" -> Make it "32".
18. Open "Unity Tweak Tool" -> "Unity" -> "Panel" -> "Indicators" -> Select "Show my name".
19. Open "Unity Tweak Tool" -> "Unity" -> "Panel" -> "Indicators" -> Select "Power" -> "Always visible".
20. Open "Unity Tweak Tool" -> "Unity" -> "Panel" -> "Indicators" -> "Default Player" -> Select "Vlc.desktop".
21. Make ".txt", ".md", ".py", ".js", ".html", ".sh", ".css" file open default application to "Sublime".
22. Make ".mkv", ".mp4", ".webm" file open default application to "VLC Player".
23. Open "System Settings" -> "Power" -> Select "Do nothing" for both of the options named as "When lid is closed".
24. Open "System Settings" -> "Brightness & Lock" -> Unselect "Dim screen to save power".
25. Open "System Settings" -> "Brightness & Lock" -> Select "Never" for "Turn screen off when inactive for".
26. Open "System Settings" -> "Time & Date" -> "Clock" -> Select "Weekday" and "Date", Month", "Year", "Seconds" and "Include week numbers".
27. Open "System Settings" -> "Software and Updates" -> "Ubuntu Software" -> Select "Main Server" for "Download From" option.
28. Open "System Settings" -> "Software and Updates" -> "Additional Drivers" -> Select "Using NVIDIA binary driver" for allowing proprietary software from NVIDIA to be installed on the machine in case NVIDIA graphics card is present -> Press "Apply Changes" button.
29. Open "System Settings" -> "Language Support" -> Drag "English(United States)" at the top of the order.
30. Open "System Settings" -> "Language Support" -> "Regional Formats" -> Select "English(United States)" -> Press "Apply System Wide" button.
31. Restart machine.
32. Open "Terminal" -> "Edit" menu -> "Profile Preferences" -> "Text Appearance" -> "Custom Font" -> "Choose A Terminal Font" -> Select "Meslo LG L DZ for Powerline Bold" -> Make font size "16".

### Notes:

1. Estimated total installation time is 2-3 hours for fresh new OS installation, although will vary based on machine and network connection performance.
2. Use command `uap` to update systems daily for ***non sudo*** users.
