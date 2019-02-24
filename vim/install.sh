#!/usr/bin/env bash

set -e

if [ -d ~/.vim/ ] || [ -f ~/.viminfo ] || [ -f ~/.vimrc ]; then
    while true; do
        read -p "Existing vim related files found in your home directory. Should I clobber (Y/n)?" yn
        case $yn in
            [Nn]* ) echo "";
                    echo "Please back up files and try again";
                    exit
                    ;;
            [Yy]* ) break
                    ;;
            * ) echo "Please answer yes or no."
                    ;;
        esac
    done
fi

rm -rf ~/.vim*

ln -sf $PWD/vimrc ~/.vimrc

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
         https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

vim +PlugInstall +qall

for package in vim-nox ruby-dev cmake python python-dev
do
   ! dpkg -l | grep -q $package && sudo apt-get -y install $package || echo "$package already installed!"
done

pushd ~/.vim/plugged/command-t/
   rake make
popd

pushd ~/.vim/plugged/YouCompleteMe/
   ./install.py --clang-completer
popd
