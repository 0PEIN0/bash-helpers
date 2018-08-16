### The purpose of this doc is to setup `bash-helpers` on a fresh server with just 3 steps. Assumes the server already has `git` and `nano` installed. Setup time: 1 min.

1. Step 1:

```bash
mkdir ~/Gitrepos
cd ~/Gitrepos
git clone https://github.com/0PEIN0/bash-helpers.git
mkdir ~/helper-scripts
cp ~/Gitrepos/bash-helpers/src/bash/sample-personal.sh ~/helper-scripts/personal.sh
nano ~/helper-scripts/personal.sh
cd ~/Gitrepos/bash-helpers
```

2. Step 2:

```bash
cat <<EOF > ~/.bash_aliases
if [ -f /home/$USER/helper-scripts/personal.sh ]; then
    . /home/$USER/helper-scripts/personal.sh
fi;
EOF
source ~/.bashrc
bash_refresh
```

3. Step 3:

```bash
sudo su
```

***Change the `ubuntu` sub-string before running the following command***

```bash
cat <<EOF > ~/.bash_aliases
if [ -f /home/ubuntu/helper-scripts/personal.sh ]; then
    . /home/ubuntu/helper-scripts/personal.sh
fi;
EOF
source ~/.bashrc
bash_refresh
```
