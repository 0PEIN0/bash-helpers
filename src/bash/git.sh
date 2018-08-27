#!/bin/bash

git config --global user.name "$SYSTEM_USER_FULL_NAME"
GIT_COMMITTER_NAME="$SYSTEM_USER_FULL_NAME"
GIT_AUTHOR_NAME="$SYSTEM_USER_FULL_NAME"
git config --global user.email "$SYSTEM_USER_EMAIL"
GIT_COMMITTER_EMAIL="$SYSTEM_USER_EMAIL"
GIT_AUTHOR_EMAIL="$SYSTEM_USER_EMAIL"

gitInstall(){
  # Install Git
  printf 'y\n' | sudo apt-get install git git-core
}

gitResetHard() {
  branchName="$(git rev-parse --abbrev-ref HEAD)"
  git reset --hard origin/"${branchName}"
}

gitCheckout() {
  funcName=$(getFunctionName)
  if [ -z "$1" ]; then
    echo "null value is not allowed as first parameter for method: \"${funcName}\"! You must pass the required parameter(s)."
    return $1
  fi;
  printf 'yes\n' | git fetch --all
  git checkout $1
  gitResetHard
}

gitRebase() {
  funcName=$(getFunctionName)
  if [ -z "$1" ]; then
    echo "null value is not allowed as first parameter for method: \"${funcName}\"! You must pass the required parameter(s)."
    return $1
  fi;
  printf 'yes\n' | git fetch --all
  git rebase origin/$1
}

alias bash_helpers="cd $BASH_HELPER_GIT_FOLDER"
alias bash_helpers_rdp="cd $BASH_HELPER_GIT_FOLDER && git_rdp && goToRoot"
alias bitbucket_auth='printf "yes\n" | ssh -T git@bitbucket.com'
alias bitbucket_keyscan_non_sudo="ssh-keyscan -t rsa bitbucket.com >> $SYSTEM_ROOT_FOLDER/.ssh/known_hosts"
alias bitbucket_keyscan_sudo='ssh-keyscan -t rsa bitbucket.com >> /root/.ssh/known_hosts'
alias git_install=gitInstall
alias git_a='git add '
alias git_b='git_f && git checkout -b '
alias git_branch_name='git_f && git rev-parse --abbrev-ref HEAD' #provides current branch name
alias git_bc='git_f && gitCheckout '
alias git_c=gitCheckout
alias git_cc='git commit -m "Rebased and resolved conflicts after rebasing from base branch."'
alias git_clone='git_repo && git clone '
alias git_co='git commit -m '
alias git_exclude_ignored_files='git ls-files -ci --exclude-standard -z | xargs -0 git rm --cached'
alias git_exclude_list='git ls-files -ci --exclude-standard'
alias git_f='printf "yes\n" | git fetch --all'
alias git_l='git_f && git log'
alias git_p='git push origin HEAD -f'
alias git_r=gitRebase
alias git_repo="cd $SYSTEM_ROOT_GIT_REPO_FOLDER"
alias git_rc='git rebase --continue'
alias git_rd='gitRebase develop'
alias git_rdp='git_rd && git_p'
alias git_remove_last_commit='git reset --hard HEAD^'
alias git_rh='git_f && gitResetHard'
alias git_rl='git_f && git reflog'
alias git_rm='git_r master'
alias git_s='git_f && git status'
alias git_set_name="git config --global user.name '$SYSTEM_USER_FULL_NAME'"
alias git_set_email="git config --global user.email '$SYSTEM_USER_EMAIL'"
alias github_auth='printf "yes\n" | ssh -T git@github.com'
alias github_keyscan_non_sudo="ssh-keyscan -t rsa github.com >> $SYSTEM_ROOT_FOLDER/.ssh/known_hosts"
alias github_keyscan_sudo='ssh-keyscan -t rsa github.com >> /root/.ssh/known_hosts'
alias gpg_config='git config --global gpg.program gpg2'
alias gpg_export='gpg --armor --export'
alias gpg_gen='gpg --gen-key'
alias gpg_list='gpg --list-secret-keys --keyid-format LONG'
alias gpg_sign='git config --global user.signingkey'
