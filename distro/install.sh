#!/usr/bin/env bash

set -e

sudo apt-get update

for package in $(cat packagelist)
do
    if dpkg -s $package;then
        echo "$package already installed!"
    else
        echo "$package needs to be installed"
        sudo apt-get -y install $package
    fi
done

if ! [ -d ~/.oh-my-zsh/ ];then
    curl -o /tmp/install.sh https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh
    sed -i 's/env zsh -l//g' /tmp/install.sh
    sh /tmp/install.sh
    echo "unsetopt BEEP" >> ~/.zshrc
    echo 'PROMPT="$fg[cyan]%}$USER@%{$fg[blue]%}%m ${PROMPT}"' >> ~/.zshrc
fi

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

cat << EOF > ~/.lesskey
#env
LESS = -i -R -q
EOF
lesskey

if ! [ -d ~/.oh-my-zsh/custom/themes/powerlevel9k ];then
   git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
   # set ZSH_THEME="powerlevel9k/powerlevel9k"
fi

if ! [ -f ~/.fonts/fontawesome-regular.ttf ];then
    ! [ -d ~/.fonts ] && mkdir -p ~/.fonts
    if ! [ -d ~/awesome-terminal-fonts ];then
        git clone https://github.com/gabrielelana/awesome-terminal-fonts.git ~/awesome-terminal-fonts
        cp -vr ~/awesome-terminal-fonts/build/* ~/.fonts
        rm -rf ~/awesome-terminal-fonts
        fc-cache -fv ~/.fonts
        fc-list | grep fontawesome-regular.ttf
        #TODO set POWERLEVEL9K_MODE='awesome-fontconfig' underneath ZSH_THEME
    fi
fi

#change /bin/sh from dash to bash
echo "dash dash/sh boolean false" | sudo debconf-set-selections
sudo DEBIAN_FRONTEND=noninteractive dpkg-reconfigure dash

if ! dpkg -s bat;then
    version=0.11.0
    package=bat_${version}_amd64.deb
    wget https://github.com/sharkdp/bat/releases/download/v0.11.0/$package -P /tmp
    sudo apt-get install /tmp/$package
    rm -v /tmp/$package
    echo "alias cat='bat'" >> ~/.zshrc
    echo "bat has been installed and an alias to cat has been created"
fi

if ! dpkg -s diskus;then
    version=0.5.0
    package=diskus_${version}_amd64.deb
    wget "https://github.com/sharkdp/diskus/releases/download/v0.5.0/$package" -P /tmp
    sudo apt-get install /tmp/$package
    rm -vf /tmp/$package

fi

if ! grep xterm-256color ~/.zshrc;then
sed -i '1s/^/export TERM=\"xterm-256color\"\n/' ~/.zshrc
fi

#deals with issue where the right click on the touchpad for dell xps 15 doesn't work
gsettings set org.gnome.desktop.peripherals.touchpad click-method areas

echo "*******************************"
echo "distro configured successfully!"
echo "*******************************"
