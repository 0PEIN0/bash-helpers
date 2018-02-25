# Bash Helpers
Bash helper scripts for system package installation and python/nodejs developers. MIT license, hell yeah!

Intended to help software engineers working on python/django and nodejs environment. The scripts that were used below are only tested on **Ubuntu 16.04 LTS**. There will be no OS version specific package changes on the script until **Ubuntu 18.04 LTS** release. We will need to wait a few months after release to get all the packages for 18.04 version, so you can expect to use **Ubuntu 18.04 LTS** somewhere in September-November 2018.

>Legends:

1. `bash-helpers` is the name of the repository and the folder name where this repository is cloned.
2. `helper-scripts` is that place where you place your `personal.sh` bash files as well as your other scripts that are meant to customize your local machine  environment.

# New System Installation Instructions

### LOGIN TO THE SYSTEM FOR THE FIRST TIME
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
12. Open "Firefox" -> Visit "https://www.google.com/chrome/browser/desktop/index.html" -> Download the 64-bit deb file and install Chrome.
13. Open "Chrome" -> Visit "https://www.dropbox.com/install-linux" -> Download the 64-bit deb file and install Dropbox. ***Why would you not use Dropbox when it provides backups to your most useful files and is present in all major OS?!***
14. Login to Chrome with google account.
15. Open terminal.

### IN NON SUDO USER MODE
1. Create ***Gitrepos*** folder in the user directory. Path will look like this: **/home/$SYSTEM_USER_NAME/Gitrepos/**. Here ***$SYSTEM_USER_NAME*** denotes the user name of the operating system(Ubuntu in this case) user, which is not the default ***root*** user. Create the folder using this command: `mkdir -p ~/Gitrepos`.
2. Run `sudo su` command(enter into the sudo user mode).

### NOW SWITCHED TO SUDO USER MODE
1. Run `sudo apt-get update` command.
2. Run `sudo apt-get install git` command to install **git** package.
3. Run `exit` command to exit from sudo mode user.

### NOW SWITCHED TO NON SUDO USER MODE
1. Open "Chrome" and go to [Bash Helper's Repository](https://github.com/0PEIN0/bash-helpers) and clone it in Gitrepos folder by running following commands:
```sh
$ cd /home/$SYSTEM_USER_NAME/Gitrepos/
$ git clone https://github.com/0PEIN0/bash-helpers.git
```
Here ***$SYSTEM_USER_NAME*** denotes the user name of the operating system(Ubuntu in this case) user, which is not the default ***root*** user.
2. After cloning, create a new directory again inside of user directory. Path will look like this: **/home/$SYSTEM_USER_NAME/helper-scripts/**. Here ***$SYSTEM_USER_NAME*** denotes the user name of the operating system(Ubuntu in this case) user, which is not the default ***root*** user. After you have created this folder, create a new file there(inside the newly created folder) called ***personal.sh***. Copy the file contents from [***sample-personal.sh***](src/bash/sample-personal.sh) file from the current repository to ***/home/$SYSTEM_USER_NAME/helper-scripts/personal.sh*** file. Then just configure your info in ***personal.sh*** file like this:

>`SYSTEM_USER_FULL_NAME="John Doe"`

>`SYSTEM_USER_EMAIL="john@example.com"`

>`SYSTEM_USER_NAME="john"`

>`DEFAULT_PERMISSION_VALUE=777`

3. Open ***~/.bash_aliases*** file and add the import of the **/home/$SYSTEM_USER_NAME/helper-scripts/personal.sh** file there. Then source it. Run `gedit ~/.bash_aliases` from command line to open up the file.
4. Below is a sample example for import of personal bash file in ***~/.bash_aliases*** file. Remember to replace the ***$SYSTEM_USER_NAME*** string here with actual operating system username.
```bash
if [ -f /home/$SYSTEM_USER_NAME/helper-scripts/personal.sh ]; then
    . /home/$SYSTEM_USER_NAME/helper-scripts/personal.sh
fi;
```
5. Run `source ~/.bashrc` command.
6. Run `system_init_non_sudo_first` command.
7. Run `admin` command(enter into the sudo user mode).

### NOW SWITCHED BACK TO SUDO USER MODE
1. Open ***~/.bash_aliases*** file and add the import of the **/home/$SYSTEM_USER_NAME/helper-scripts/personal.sh** file there. Then source it. Run `gedit ~/.bash_aliases` from command line to open up the file.
2. Below is a sample example for import of personal bash file in ***~/.bash_aliases*** file. Remember to replace the ***$SYSTEM_USER_NAME*** string here with actual operating system username.
```bash
if [ -f /home/$SYSTEM_USER_NAME/helper-scripts/personal.sh ]; then
    . /home/$SYSTEM_USER_NAME/helper-scripts/personal.sh
fi;
```
3. Run `source ~/.bashrc` command.
4. Run `system_init_sudo` command. This command will take approximately 2-4 hours, have a snack/coffee in this period.
5. Restart machine.
6. Enter sudo user mode again after restart by running `admin` command.
7. Run `gedit ~/.zshrc` (change the zsh theme to "agnoster", or any of your preferred theme, and add the reference to personal bash file as well located in bash-dump folder). Same operation as `gedit ~/.bash_aliases` step. Place the following script at the end of `~/.zshrc` file. Remember to replace the ***$SYSTEM_USER_NAME*** string here with actual operating system username.
```bash
if [ -f /home/$SYSTEM_USER_NAME/helper-scripts/personal.sh ]; then
    . /home/$SYSTEM_USER_NAME/helper-scripts/personal.sh
fi;
```

8. And add a line with just only `zsh` string on a new line at the end of `~/.bash_aliases` file. Then run `source ~/.zshrc`.
9. Do the following postgres operation after replacing ***$SYSTEM_USER_NAME*** value in the sql script below. You can enter the postgres shell by entering `postgres_shell_sudo` command.
```sql
ALTER USER postgres PASSWORD '$SYSTEM_USER_NAME'; ALTER role postgres PASSWORD '$SYSTEM_USER_NAME'; CREATE ROLE $SYSTEM_USER_NAME LOGIN PASSWORD '$SYSTEM_USER_NAME';CREATE USER $SYSTEM_USER_NAME WITH PASSWORD '$SYSTEM_USER_NAME'; alter ROLE $SYSTEM_USER_NAME LOGIN PASSWORD '$SYSTEM_USER_NAME';alter USER $SYSTEM_USER_NAME WITH PASSWORD '$SYSTEM_USER_NAME';ALTER ROLE $SYSTEM_USER_NAME SET client_encoding TO 'utf8'; ALTER ROLE $SYSTEM_USER_NAME SET default_transaction_isolation TO 'read committed' ;ALTER ROLE $SYSTEM_USER_NAME SET timezone TO 'UTC';alter role $SYSTEM_USER_NAME superuser;CREATE EXTENSION postgis;CREATE EXTENSION postgis_topology;CREATE EXTENSION postgis_sfcgal;CREATE EXTENSION fuzzystrmatch;CREATE EXTENSION address_standardizer;CREATE EXTENSION address_standardizer_data_us;CREATE EXTENSION postgis_tiger_geocoder;
```
Type and enter `\q` to exit from postgres shell.

10. Run `ssh_keygen` command. Press `Enter` when prompted to choose `/root/.ssh/id_rsa` file. Then provide a passphrase for the ssh. Do remember this passphrase.
11. Run `get_ssh` command. This will copy the generated ssh public key to clipboard.
12. Add the ssh public key at [Github](https://github.com/settings/ssh/new), [Gitlab](https://gitlab.com/profile/keys) and [Bitbucket](https://bitbucket.org/account/user/PEIN/ssh-keys/).
13. Run `ssh_sudo_setup` command to authenticate with Github, Gitlab and Bitbucket from command line.
14. Run `install_nodejs` command to install nodejs.
15. Run this command to install all the necessary global packages via npm: `node_update`. If there is a infinite for loop message that is appearing in console, press `Ctrl + C` to stop it. Run this command at some other time in that case.
16. Run `exit` command.

### NOW SWITCHED BACK TO NON SUDO USER MODE, THAT IS YOUR PERSONAL SYSTEM USER
1. Run `system_init_non_sudo_second` command.
2. Run `gedit ~/.zshrc` (change the zsh theme to "agnoster", or any of your preferred theme, and add the reference to personal bash file as well located in bash-dump folder). Same operation as `gedit ~/.bash_aliases` step. Place the following script at the end of `~/.zshrc` file. Remember to replace the ***$SYSTEM_USER_NAME*** string here with actual operating system username.
```bash
if [ -f /home/$SYSTEM_USER_NAME/helper-scripts/personal.sh ]; then
    . /home/$SYSTEM_USER_NAME/helper-scripts/personal.sh
fi;
```

3. And add a line with just only `zsh` string on a new line at the end of `~/.bash_aliases` file. Then run `source ~/.zshrc`.
4. Run `source ~/.zshrc`. If you see some weird bash error when sourcing, just ignore it. It should be fixed after restarting the machine.
5. Restart machine.
6. Run `ssh_keygen` command. Press `Enter` when prompted to choose `/home/$SYSTEM_USER_NAME/.ssh/id_rsa` file. Then provide a passphrase for the ssh. Do remember this passphrase.
7. Run `get_ssh` command. This will copy the generated ssh public key to clipboard.
8. Add the ssh public key at [Github](https://github.com/settings/ssh/new), [Gitlab](https://gitlab.com/profile/keys) and [Bitbucket](https://bitbucket.org/account/user/PEIN/ssh-keys/).
9. Run `ssh_non_sudo_setup` command to authenticate with Github, Gitlab and Bitbucket from command line.
10. Cheers! You're all set.

### Usage Notes:

1. Estimated total installation time is 2-5 hours for fresh new OS installation, although it will vary based on machine and network connection performance.
2. Use command `uap` to update systems daily for ***non sudo*** user(s). And `uar` command for ***sudo*** user(s). The `uap` command will ensure the daily pull for latest changes on repositories that resides in `~/Gitrepos` folder.
3. For further OS customization, you can take a look into [this](personalized-manual-intervention.md) file. This is a personalized OS environment file for myself, but you might get some idea as to what some of the customizations may look like.

### Other similar projects that inspired this repository:

1. [Brilliant Bash](https://github.com/roytenberg/brilliant-bash) by [Ben Roytenberg](https://github.com/roytenberg).
2. [shell-scripts](https://github.com/trevordmiller/shell-scripts) by [Trevor D. Miller](https://github.com/trevordmiller).
3. [Bash Startup Scripts](https://github.com/wd5gnr/bashrc) by [wd5gnr](https://github.com/wd5gnr)
3. [aliasme](https://github.com/Jintin/aliasme) by [Jintin](https://github.com/Jintin).
4. [dotfiles](https://github.com/shazow/dotfiles) by [Andrey Petrov](https://github.com/shazow).
5. [bash-common-helpers](https://github.com/martinburger/bash-common-helpers) by [Martin Burger](https://github.com/martinburger).
6. [git-bash-helpers](https://github.com/jonathantneal/git-bash-helpers) by [Jonathan Neal](https://github.com/jonathantneal).
7. [Bash helpers gist](https://gist.github.com/mpneuried/5916618) by [M. Peter](https://github.com/mpneuried)
8. [bash-it](https://github.com/Bash-it/bash-it) by [Bash-it](https://github.com/Bash-it)
