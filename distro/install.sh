#!/usr/bin/env bash

set -e

for package in $(cat packagelist)
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
git config --global diff.tool vimdiff
git config --global difftool.prompt false
git config --global alias.d difftool

if ! [ -f ~/.fzf/install-complete ];then
    rm -rf ~/.fzf
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    pushd ~/.fzf
        ./install --all
        touch install-complete
    popd
    source ~/.bashrc
else
    echo ""
    echo "*** fzf already installed! ***"
    echo ""
fi

if ! grep -q bell-style ~/.bashrc;then
    echo "bind 'set bell-style none'" >> ~/.bashrc
fi

sudo usermod -a -G dialout $USER

sudo chsh -s /bin/bash

BLUETOOTH_CONFIG=/etc/bluetooth/main.conf
if grep -q '#ControllerMode = dual' $BLUETOOTH_CONFIG;then
    sudo sed -ie '/#ControllerMode/s/^.//'          $BLUETOOTH_CONFIG
    sudo sed -i  '/ControllerMode /s/=.*$/= bredr/' $BLUETOOTH_CONFIG
    sudo systemctl restart bluetooth
fi

cat << EOF > ~/.gdbinit
define hook-next
  refresh
end
EOF
echo "*******************************"
echo "distro configured successfully!"
echo "*******************************"
