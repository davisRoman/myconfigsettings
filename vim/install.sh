#!/usr/bin/env bash

set -ex

for package in $(cat packagelist)
do
   ! dpkg -l | grep -q $package && sudo apt-get -y --allow-unauthenticated install $package || echo "$package already installed!"
done

ln -sf $PWD/vimrc ~/.vimrc

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
         https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

vim +PlugInstall +qall

pushd ~/.vim/plugged/command-t/
    if ! [ -f compile-complete ];then
        rake make
        touch compile-complete
    else
        echo ""
        echo "*** command-t already compiled! ***"
        echo ""
    fi
popd

pushd ~/.vim/plugged/YouCompleteMe/
    #In case you get the error "Virtual memory exhausted: Cannot allocate memory"
    # due to not enough onboard memory
    if ! [ -f compile-complete ];then
        if [ -f /etc/rpi-issue ];then
            sudo fallocate -l 1G ~/swapfile
            sudo chmod 600 ~/swapfile
            sudo mkswap ~/swapfile
            sudo swapon ~/swapfile
            sudo swapon -s
            #https://nallerooth.com/post/building_ycm_on_raspberry_pi_3/
            YCM_CORES=1 ./install.py --clang-completer
            sudo swapoff -a
            rm -f ~/swapfile
        else
           ./install.py --clang-completer
        fi
        touch compile-complete
    else
        echo ""
        echo "*** YouCompleteMe already compiled! ***"
        echo ""
    fi
popd

ln -svf $PWD/.ycm_extra_conf.py ~/.vim/.ycm_extra_conf.py

echo "****************************"
echo "vim configured successfully!"
echo "****************************"
