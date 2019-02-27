#!/usr/bin/env bash

set -e

for package in $(cat packagelist)
do
   ! dpkg -l | grep -q $package && sudo apt-get -y install $package || echo "$package already installed!"
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
    # sudo fallocate -l 1G ~/swapfile
    # sudo chmod 600 ~/swapfile
    # sudo mkswap ~/swapfile
    # sudo swapon ~/swapfile
    # sudo ~/swapon -s
    if ! [ -f compile-complete ];then
        if [ -f /etc/rpi-issue ];then
            X=1 #https://nallerooth.com/post/building_ycm_on_raspberry_pi_3/
        fi
        YCM_CORES=$X ./install.py --clang-completer
        touch compile-complete
    else
        echo ""
        echo "*** YouCompleteMe already compiled! ***"
        echo ""
    fi
popd

echo "****************************"
echo "vim configured successfully!"
echo "****************************"
