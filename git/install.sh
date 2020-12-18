#!/bin/sh
set -e

if [ ! -f /etc/apt/sources.list.d/git-core*.list ]
then
    sudo add-apt-repository -yu ppa:git-core/ppa
fi

if [ ! $(which git) ]
then
    sudo apt -y install git git-extras
fi

ln -nsf $PWD/git/gitignore ~/.gitignore
ln -nsf $PWD/git/gitmessage ~/.gitmessage

if [ ! $(git config --global user.email) ]
then
    echo ' - What is your github author name?'
    read GIT_AUTHOREMAIL </dev/tty
    git config --global user.email "$GIT_AUTHOREMAIL"
fi

if [ ! $(git config --global user.signingkey) ]
then
    echo ' - What is your github signing key?'
    read GIT_SIGNINGKEY </dev/tty
    git config --global user.signingkey "$GIT_SIGNINGKEY"
    git config --global commit.gpgsign true
fi

git config --global user.name "Geert Eltink"
git config --global core.autocrlf "input"
git config --global core.eol "lf"
git config --global core.excludesfile "~/.gitignore"
git config --global core.fscache true
git config --global commit.template "~/.gitmessage"
git config --global format.commitMessageColumns 100
git config --global push.default "simple"
git config --global pull.rebase true
git config --global alias.aliases "config --get-regexp '^alias\\.'"
git config --global alias.st "status --short --branch"
git config --global alias.df "diff --ignore-space-at-eol --ignore-space-change --ignore-all-space --ignore-blank-lines"
git config --global alias.last-tag "describe --abbrev=0 --tags"
git config --global alias.ld "log --pretty=format:'%C(green)%h %C(yellow)[%ad]%Cred%d %Creset%s%Cblue [%cn]' --decorate --date=relative"
git config --global alias.lg "log --pretty=format:'%C(yellow)%h %C(green)%ad%Cred%d %Creset%s%Cblue [%cn]' --decorate --date=short --graph"

exit 0

#    set-upstream = "!f() { git remote add upstream ${1}; git remote set-url upstream ${1}; git remote set-url --push upstream no_push; git remote -v;  }; f"
#    sync-upstream = "!f() { ref=${1-master}; git checkout $ref && git fetch upstream $ref && git rebase upstream/$ref && git push origin $ref;  }; f"
