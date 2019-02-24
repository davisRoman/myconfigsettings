#!/usr/bin/env bash

set -e

for package in minicom xterm tmux cscope exuberant-ctags
do
    if ! dpkg -l | grep -q $package;then
        echo "$package needs to be installed"
        sudo apt-get install $package
    else
        echo "$package already installed!"
    fi
done

