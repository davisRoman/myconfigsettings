#!/usr/bin/env bash

set -e

for package in git minicom xterm tmux tig lsof curl g++ htop silversearcher-ag meld
do
    if ! dpkg -l | grep -q $package;then
        echo "$package needs to be installed"
        sudo apt-get -y install $package
    else
        echo "$package already installed!"
    fi
done

git config --global core.editor "vim"
git config --global user.name   "davis roman"

if ! [ -f ~/.fzf/install-complete ];then
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    pushd ~/.fzf
        ./install --all
        touch install-complete
    popd
else
    echo ""
    echo "*** fzf already installed! ***"
    echo ""
fi
