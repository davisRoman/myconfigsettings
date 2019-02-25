#!/usr/bin/env bash

set -e

for package in vim-nox ruby-dev cmake python python-dev cscope exuberant-ctags
do
   ! dpkg -l | grep -q $package && sudo apt-get -y install $package || echo "$package already installed!"
done

ln -sf $PWD/vimrc ~/.vimrc

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
         https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

vim +PlugInstall +qall

pushd ~/.vim/plugged/command-t/
   rake make
popd

pushd ~/.vim/plugged/YouCompleteMe/
    #In case you get the error "Virtual memory exhausted: Cannot allocate memory"
    # due to not enough onboard memory
    # sudo fallocate -l 1G ~/swapfile
    # sudo chmod 600 ~/swapfile
    # sudo mkswap ~/swapfile
    # sudo swapon ~/swapfile
    # sudo ~/swapon -s
    [ -f /etc/rpi-issue ] && X=1 #https://nallerooth.com/post/building_ycm_on_raspberry_pi_3/
    YCM_CORES=$X ./install.py --clang-completer
popd
