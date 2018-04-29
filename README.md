# Bash Helpers
Bash helper scripts for system package installation and python/nodejs developers. MIT license, hell yeah!

Intended to help software engineers working on python/django and nodejs environment. The scripts that were used below are only on **Ubuntu 16.04 LTS**, **Ubuntu 18.04 LTS** and **Odroid MC1 Ubuntu Core**. There will be no OS version specific package changes on the script until **Ubuntu 18.04 LTS** release. We will need to wait a few months after release to get all the packages for 18.04 version, so you can expect to use **Ubuntu 18.04 LTS** somewhere in 2018 September-December.

>Legends:

1. `bash-helpers` is the name of the repository and the folder name where this repository is cloned.
2. `helper-scripts` is that place where you place your `personal.sh` bash files as well as your other scripts that are meant to customize your local machine  environment.

# Usage Instruction

For usage instruction ***with*** new OS installations, follow [these](docs/new-os-setup.md) instructions.
Otherwise, open new terminal for usage instruction without new OS installations.

### IN NON SUDO USER MODE
1. Create ***Gitrepos*** folder in the user directory. Path will look like this: **/home/$SYSTEM_USER_NAME/Gitrepos/**. Here ***$SYSTEM_USER_NAME*** denotes the user name of the operating system(Ubuntu in this case) user, which is not the default ***root*** user. Create the folder using this command: `mkdir -p ~/Gitrepos`. If you are not sure about OS username, its the name that appears when login. To be sure, you can open up **Terminal** and see the username there. It'll be in `username@machine-name` format.
2. Run `sudo su` command(enter into the sudo user mode). Enter sudo user password when prompted.

### NOW SWITCHED TO SUDO USER MODE
1. Run `sudo apt-get update` command.
2. Run `sudo apt-get install git` command to install **git** package.
3. Run `exit` command to exit from sudo mode user.

### NOW SWITCHED TO NON SUDO USER MODE
1. Clone [Bash Helper's Repository](https://github.com/0PEIN0/bash-helpers) in Gitrepos folder by running following commands:

```sh
$ cd /home/$SYSTEM_USER_NAME/Gitrepos/
$ git clone https://github.com/0PEIN0/bash-helpers.git
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

3. Add the import of the **/home/$SYSTEM_USER_NAME/helper-scripts/personal.sh** file in ***~/.bash_aliases*** file. Then source it.

```bash
cat <<EOF > ~/.bash_aliases
if [ -f /home/$USER/helper-scripts/personal.sh ]; then
. /home/$USER/helper-scripts/personal.sh
fi;
EOF
source ~/.bash_aliases
```

4. Run `admin` command(enter into the sudo user mode). Enter sudo user password when prompted.

### NOW SWITCHED BACK TO SUDO USER MODE
1. Open ***~/.bash_aliases*** file and add the import of the **/home/$SYSTEM_USER_NAME/helper-scripts/personal.sh** file there. Then source it. Run `gedit ~/.bash_aliases` from command line to open up the file. Below is a sample example for import of personal bash file in ***~/.bash_aliases*** file. Remember to replace the ***$SYSTEM_USER_NAME*** string here with actual operating system username.
```bash
if [ -f /home/$SYSTEM_USER_NAME/helper-scripts/personal.sh ]; then
    . /home/$SYSTEM_USER_NAME/helper-scripts/personal.sh
fi;
```
2. Run `source ~/.bashrc` command.
3. Assuming you have **ZSH** shell setup, run `gedit ~/.zshrc` (change the zsh theme to "agnoster", or any of your preferred theme, and add the reference to personal bash file as well located in bash-dump folder). Same operation as `gedit ~/.bash_aliases` step. Place the following script at the end of `~/.zshrc` file. Remember to replace the ***$SYSTEM_USER_NAME*** string here with actual operating system username.
```bash
if [ -f /home/$SYSTEM_USER_NAME/helper-scripts/personal.sh ]; then
    . /home/$SYSTEM_USER_NAME/helper-scripts/personal.sh
fi;
```
4. ***Optional Step*** Assuming you have **ZSH** shell setup, do this only if `zsh` shell does not appear in terminal after rebooting or opening a new terminal. And add a line with just only `zsh` string on a new line at the end of `~/.bash_aliases` file. Then run `source ~/.zshrc`.
5. Run `exit` command.
6. Restart machine.
7. Cheers! You're all set.

### NOW SWITCHED BACK TO NON SUDO USER MODE, THAT IS YOUR PERSONAL SYSTEM USER (only for ZSH users)
1. Assuming you have **ZSH** shell setup, run `gedit ~/.zshrc` (change the zsh theme to "agnoster", or any of your preferred theme, and add the reference to personal bash file as well located in bash-dump folder). Same operation as `gedit ~/.bash_aliases` step. Place the following script at the end of `~/.zshrc` file. Remember to replace the ***$SYSTEM_USER_NAME*** string here with actual operating system username.
```bash
if [ -f /home/$SYSTEM_USER_NAME/helper-scripts/personal.sh ]; then
    . /home/$SYSTEM_USER_NAME/helper-scripts/personal.sh
fi;
```
2. ***Optional Step*** Assuming you have **ZSH** shell setup, do this only if `zsh` shell does not appear in terminal after rebooting or opening a new terminal. And add a line with just only `zsh` string on a new line at the end of `~/.bash_aliases` file. Then run `source ~/.zshrc`.
3. Assuming you have **ZSH** shell setup, run `source ~/.zshrc`. If you see some weird bash error when sourcing, just ignore it. It should be fixed after restarting the machine.

# Additional Usage Notes:

1. Estimated total installation time is 2-5 hours for fresh new OS installation, although it will vary based on machine and network connection performance.
2. Use command `uap` to update systems daily for ***non sudo*** user(s). And `uar` command for ***sudo*** user(s), for example: `root` user. The `uap` command will ensure the daily pull for latest changes on repositories that resides in `~/Gitrepos` folder, sync youtube music videos and replace files from sources to destinations. To use `uap` command, first create a new file in `src/python/` directory of current repository. Then add a file called `local_settings.py`. Yes, exactly this file name. After creating the file copy contents from `sample_local_settings.py` file to `local_settings.py` file. Override property values in `local_settings.py` according to your necessity.
3. For further OS customization, you can take a look into [this](docs/personalized-manual-intervention.md) file. This is a personalized OS environment file for myself, but you might get some idea as to what some of the customizations may look like.

# Other similar projects that inspired this repository:

1. [Brilliant Bash](https://github.com/roytenberg/brilliant-bash) by [Ben Roytenberg](https://github.com/roytenberg).
2. [shell-scripts](https://github.com/trevordmiller/shell-scripts) by [Trevor D. Miller](https://github.com/trevordmiller).
3. [Bash Startup Scripts](https://github.com/wd5gnr/bashrc) by [wd5gnr](https://github.com/wd5gnr).
3. [aliasme](https://github.com/Jintin/aliasme) by [Jintin](https://github.com/Jintin).
4. [dotfiles](https://github.com/shazow/dotfiles) by [Andrey Petrov](https://github.com/shazow).
5. [bash-common-helpers](https://github.com/martinburger/bash-common-helpers) by [Martin Burger](https://github.com/martinburger).
6. [git-bash-helpers](https://github.com/jonathantneal/git-bash-helpers) by [Jonathan Neal](https://github.com/jonathantneal).
7. [Bash helpers gist](https://gist.github.com/mpneuried/5916618) by [M. Peter](https://github.com/mpneuried).
8. [bash-it](https://github.com/Bash-it/bash-it) by [Bash-it](https://github.com/Bash-it).
