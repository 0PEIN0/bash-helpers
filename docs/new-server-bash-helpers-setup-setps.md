1. Step 1:

```bash
mkdir ~/Gitrepos
cd ~/Gitrepos
git clone https://github.com/0PEIN0/bash-helpers.git
mkdir ~/helper-scripts
cd ~/helper-scripts
cp ~/Gitrepos/bash-helpers/src/bash/sample-personal.sh ~/helper-scripts/personal.sh
nano ~/helper-scripts/personal.sh
```

2. Step 2:

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
```
