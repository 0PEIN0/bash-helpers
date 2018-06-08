# New System Installation Instructions

### LOGIN TO THE SYSTEM FOR THE FIRST TIME (OPTIONAL AND VALID ONLY FOR 16.04 DESKTOP)
1. Open `System Settings` in Ubuntu.
2. Go to `Brightness & Lock` -> Uncheck `Dim screen to save power`.
3. Go to `Brightness & Lock` -> Set `Turn screen off when inactive for` value to `Never`.
4. Go to `Brightness & Lock` -> Set `Lock` switch to `OFF`.
5. Go to `Brightness & Lock` -> Uncheck `Require my password when waking from suspend`.
6. Open `System Settings` in Ubuntu.
7. Go to `Power` -> `Suspend when inactive for` -> `On battery power` -> Select `Don't suspend`.
8. Go to `Power` -> `Suspend when inactive for` -> `When plugged in` -> Select `Don't suspend`.
9. Go to `Power` -> `When power critically low` -> `On battery power` -> Select `empty`.
10. Go to `Power` -> `When the lid is closed` -> `On battery power` -> Select `Do nothing`.
11. Go to `Power` -> `When the lid is closed` -> `When plugged in` -> Select `Do nothing`.
12. Open `System Settings` in Ubuntu.
13. Go to `Software & Updates` -> `Ubuntu Software` -> `Download from:` -> Select `Main server` -> Click `Close`.
14. Open "Firefox" -> Visit "https://www.google.com/chrome/browser/desktop/index.html" -> Download the 64-bit deb file and install Chrome.
15. Open "Chrome" -> Visit "https://www.dropbox.com/install-linux" -> Download the 64-bit deb file and install Dropbox. ***Why would you not use Dropbox when it provides backups to your most useful files and is present in all major OS while being free to use upto the necessary limit?!***
16. Login to Chrome with google account.
17. Run the dropbox `deb` file to install.
18. Open terminal.

### IN NON SUDO USER MODE
1. Create ***Gitrepos*** folder in the user directory. Path will look like this: **/home/$SYSTEM_USER_NAME/Gitrepos/**. Here ***$SYSTEM_USER_NAME*** denotes the user name of the operating system(Ubuntu in this case) user, which is not the default ***root*** user. Create the folder using this command: `mkdir -p ~/Gitrepos`.
2. Run `sudo su` command(enter into the sudo user mode). Enter sudo user password when prompted.

### NOW SWITCHED TO SUDO USER MODE
1. Run `sudo apt-get update` command.
2. Run `sudo apt-get install git` command to install **git** package.
3. Run `exit` command to exit from sudo mode user.

### NOW SWITCHED TO NON SUDO USER MODE
1. Clone [Bash Helper's Repository](https://github.com/0PEIN0/bash-helpers) in Gitrepos folder by running following commands:

```sh
cd /home/$SYSTEM_USER_NAME/Gitrepos/
git clone https://github.com/0PEIN0/bash-helpers.git
```

Here ***$SYSTEM_USER_NAME*** denotes the user name of the operating system(Ubuntu in this case) user, which is not the default ***root*** user.

2. After cloning, create a new directory again inside of user directory. Path will look like this: **/home/$SYSTEM_USER_NAME/helper-scripts/**. Here ***$SYSTEM_USER_NAME*** denotes the user name of the operating system(Ubuntu in this case) user, which is not the default ***root*** user. Create this directory by running the following command:

```bash
mkdir -p ~/helper-scripts
```

After you have created this folder, create a new file there(inside the newly created folder) called ***personal.sh*** and copy the file contents from [***sample-personal.sh***](src/bash/sample-personal.sh) file from the current repository to ***/home/$SYSTEM_USER_NAME/helper-scripts/personal.sh*** file. Run the following command to do so:

```bash
cp -f ~/Gitrepos/bash-helpers/src/bash/sample-personal.sh ~/helper-scripts/personal.sh
```

Then just open up ***personal.sh*** file by running `gedit ~/helper-scripts/personal.sh` command and configure your info in ***personal.sh*** file like this:

>`SYSTEM_USER_FULL_NAME="John Doe"`

>`SYSTEM_USER_EMAIL="john@example.com"`

>`SYSTEM_USER_NAME="john"`

>`DEFAULT_PERMISSION_VALUE=775`

3. Add the import of the **/home/$SYSTEM_USER_NAME/helper-scripts/personal.sh** file in ***~/.bash_aliases*** file. Then source it. Run the following commands to do so:

```bash
cat <<EOF > ~/.bash_aliases
if [ -f /home/$USER/helper-scripts/personal.sh ]; then
    . /home/$USER/helper-scripts/personal.sh
fi;
EOF
source ~/.bash_aliases
```

5. Run `system_init_non_sudo_first` command. Ignore any error that may show up in the terminal after running this command.
6. Run `admin` command(enter into the sudo user mode). Enter sudo user password when prompted.

### NOW SWITCHED BACK TO SUDO USER MODE
1. Open ***~/.bash_aliases*** file and add the import of the **/home/$SYSTEM_USER_NAME/helper-scripts/personal.sh** file there. Then source it. Run `gedit ~/.bash_aliases` from command line to open up the file. Below is a sample example for import of personal bash file in ***~/.bash_aliases*** file. Remember to replace the ***$SYSTEM_USER_NAME*** string here with actual operating system username.
```bash
if [ -f /home/$SYSTEM_USER_NAME/helper-scripts/personal.sh ]; then
    . /home/$SYSTEM_USER_NAME/helper-scripts/personal.sh
fi;
```
2. Run `source ~/.bashrc` command.
3. Run `system_init_sudo` command. This command will take approximately 2-4 hours, have a snack/coffee in this period. Will install all the required packages in sudo mode. All the packages that will installed from this command can be found [here](list-of-packages.md). Type in `exit` once the package installations have completed.
4. Enter sudo user mode again after restart by running `admin` command after opening terminal.
5. Run `gedit ~/.zshrc` (change the zsh theme to "agnoster", or any of your preferred theme, and add the reference to personal bash file as well located in bash-dump folder). Same operation as `gedit ~/.bash_aliases` step. Place the following script at the end of `~/.zshrc` file. Remember to replace the ***$SYSTEM_USER_NAME*** string here with actual operating system username.
```bash
if [ -f /home/$SYSTEM_USER_NAME/helper-scripts/personal.sh ]; then
    . /home/$SYSTEM_USER_NAME/helper-scripts/personal.sh
fi;
```

6. ***Optional Step*** Do this only if `zsh` shell does not appear in terminal after rebooting or opening a new terminal. And add a line with just only `zsh` string on a new line at the end of `~/.bash_aliases` file. Then run `source ~/.zshrc`.
7. Do the following postgres operation after replacing ***$SYSTEM_USER_NAME*** value in the sql script below. You can enter the postgres shell by entering `postgres_shell_sudo` command.
```sql
ALTER USER postgres PASSWORD '$SYSTEM_USER_NAME'; ALTER role postgres PASSWORD '$SYSTEM_USER_NAME'; CREATE ROLE $SYSTEM_USER_NAME LOGIN PASSWORD '$SYSTEM_USER_NAME';CREATE USER $SYSTEM_USER_NAME WITH PASSWORD '$SYSTEM_USER_NAME'; alter ROLE $SYSTEM_USER_NAME LOGIN PASSWORD '$SYSTEM_USER_NAME';alter USER $SYSTEM_USER_NAME WITH PASSWORD '$SYSTEM_USER_NAME';ALTER ROLE $SYSTEM_USER_NAME SET client_encoding TO 'utf8'; ALTER ROLE $SYSTEM_USER_NAME SET default_transaction_isolation TO 'read committed' ;ALTER ROLE $SYSTEM_USER_NAME SET timezone TO 'UTC';alter role $SYSTEM_USER_NAME superuser;CREATE EXTENSION postgis;CREATE EXTENSION postgis_topology;CREATE EXTENSION postgis_sfcgal;CREATE EXTENSION fuzzystrmatch;CREATE EXTENSION address_standardizer;CREATE EXTENSION address_standardizer_data_us;CREATE EXTENSION postgis_tiger_geocoder;
```
Type and enter `\q` to exit from postgres shell.

8. Run this command to install all the necessary global packages via npm: `node_update`. If there is a infinite for loop message that is appearing in console, press `Ctrl + C` to stop it. Run this command at some other time in that case.
9. Run `exit` command.
10. Restart machine.

### NOW SWITCHED BACK TO NON SUDO USER MODE, THAT IS YOUR PERSONAL SYSTEM USER
1. Run `system_init_non_sudo_second` command.
2. Run `gedit ~/.zshrc` (change the zsh theme to "agnoster", or any of your preferred theme, and add the reference to personal bash file as well located in bash-dump folder). Same operation as `gedit ~/.bash_aliases` step. Place the following script at the end of `~/.zshrc` file. Remember to replace the ***$SYSTEM_USER_NAME*** string here with actual operating system username.
```bash
if [ -f /home/$SYSTEM_USER_NAME/helper-scripts/personal.sh ]; then
    . /home/$SYSTEM_USER_NAME/helper-scripts/personal.sh
fi;
```

3. ***Optional Step*** Do this only if `zsh` shell does not appear in terminal after rebooting or opening a new terminal. And add a line with just only `zsh` string on a new line at the end of `~/.bash_aliases` file. Then run `source ~/.zshrc`.
4. Run `source ~/.zshrc`. If you see some weird bash error when sourcing, just ignore it. It should be fixed after restarting the machine.
5. Restart machine.
6. Run `ssh_keygen` command. Press `Enter` when prompted to choose `/home/$SYSTEM_USER_NAME/.ssh/id_rsa` file. Then provide a passphrase for the ssh. Do remember this passphrase for future usage.
7. Run `get_ssh` command. This will copy the generated ssh public key to clipboard.
8. Add the ssh public key at [Github](https://github.com/settings/ssh/new), [Gitlab](https://gitlab.com/profile/keys) and [Bitbucket](https://bitbucket.org/account).
9. Run `ssh_non_sudo_setup` command to authenticate with Github, Gitlab and Bitbucket from command line.
10. Cheers! You're all set.
