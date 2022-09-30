#!/usr/bin/env bash
set -Eueo pipefail

if [ ! -f /etc/apt/sources.list.d/git-core*.list ]
then
    sudo add-apt-repository -yu ppa:git-core/ppa
fi

if [ ! -f /etc/apt/sources.list.d/github-cli.list ]
then
  curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo gpg --dearmor -o /usr/share/keyrings/githubcli-archive-keyring.gpg
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
  sudo apt update
fi

PACKAGES=(
  git
  git-extras
  gh
)

for pkg in "${PACKAGES[@]}"; do
  dpkg -s $pkg > /dev/null 2>&1 || sudo apt -y install $pkg
done

ln -nsf $PWD/git/gitignore ~/.gitignore

if [ ! $(git config --global user.email) ]
then
    echo ' - What is your git email?'
    read GIT_USER_EMAIL </dev/tty
    git config --global user.email "$GIT_USER_EMAIL"
fi

if [ ! $(git config --global user.signingkey) ]
then
    EMAIL=$(git config --global user.email)
    GIT_SIGNING_KEY=$(gpg --list-secret-keys --keyid-format=LONG "$EMAIL" | grep 'sec' | grep -o -P '(?<=/)[A-Z0-9]{16}')
    git config --global user.signingkey "$GIT_SIGNING_KEY"
    git config --global commit.gpgsign true
fi

git config --global user.name "Geert Eltink"
git config --global core.autocrlf "input"
git config --global core.eol "lf"
git config --global core.excludesfile "~/.gitignore"
git config --global core.fscache true
git config --global init.defaultBranch "main"
git config --global format.commitMessageColumns 100
git config --global fetch.prune true
git config --global push.default "simple"
git config --global pull.rebase true
git config --global rebase.autoStash true
git config --global alias.aliases "config --get-regexp '^alias\\.'"
git config --global alias.st "status --short --branch"
git config --global alias.df "diff --ignore-space-at-eol --ignore-space-change --ignore-all-space --ignore-blank-lines"
git config --global alias.last-tag "describe --abbrev=0 --tags"
git config --global alias.l "log --pretty=format:'%C(yellow)%h %Creset%s%Cblue <%cn>' --no-merges --date=short"
git config --global alias.lg "log --pretty=format:'%C(yellow)%h %C(green)%ad%Cred%d %Creset%s%Cblue <%cn>' --no-merges --date=short"
git config --global alias.yolo '!git commit -m "$(curl -s whatthecommit.com/index.txt)"'
git config --global alias.gone "! git fetch -p && git for-each-ref --format '%(refname:short) %(upstream:track)' | awk '\$2 == \"[gone]\" {print \$1}' | xargs -r git branch -D"

exit 0

#    set-upstream = "!f() { git remote add upstream ${1}; git remote set-url upstream ${1}; git remote set-url --push upstream no_push; git remote -v;  }; f"
#    sync-upstream = "!f() { ref=${1-master}; git checkout $ref && git fetch upstream $ref && git rebase upstream/$ref && git push origin $ref;  }; f"
