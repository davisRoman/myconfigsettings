#!/bin/bash

set -e 

if ! javac -version;then
    chmod a+x jdk-6u45-linux-x64.bin
    sudo mkdir -p /usr/lib/jvm
    sudo cp jdk-6u45-linux-x64.bin /usr/lib/jvm/
    pushd /usr/lib/jvm/
        sudo ./jdk-6u45-linux-x64.bin
        sudo rm jdk-6u45-linux-x64.bin
        sudo ln -s -b /usr/lib/jvm/jdk1.6.0_45/jre/bin/java /etc/alternatives/java
    popd
    
    echo "JAVA_HOME=/usr/lib/jvm/jdk1.6.0_45" >> ~/.zshrc
    echo "PATH=\$PATH:\$JAVA_HOME/bin"          >> ~/.zshrc
    
    source ~/.zshrc
    
    echo "JAVA_HOME is set to: $JAVA_HOME"
else
    echo "java is installed correctly"
fi

#Install Additional Android Components
for package in "$(cat packagelist-essentials)"
do
    if ! dpkg -l | grep -q $package;then
        echo "$package needs to be installed"
        sudo apt-get -y install $package
    else
        echo "$package already installed!"
    fi
done


#Additional Boot Camp Components
for package in "$(cat packagelist-bootcamp)"
do
    if ! dpkg -l | grep -q $package;then
        echo "$package needs to be installed"
        sudo apt-get -y install $package
    else
        echo "$package already installed!"
    fi
done

#setup local bin directory
mkdir -vp ~/bin

#update the path so ~/bin becomes globally accessible
echo "PATH=~/bin:\$PATH" >> ~/.zshrc
zenity --info --text="PLEASE RUN: source ~/.zshrc"

if ! [ -f ~/bin/make ];then
    #revert to gnu make 3.82
    wget https://ftp.gnu.org/gnu/make/make-3.82.tar.gz
    tar xvf make-3.82.tar.gz
    cd make-3.82/
    ./configure
    make
    cp -v make ~/bin
    cd ..
    rm -rvf make-3.82
    rm make-3.82.tar.gz
else
    echo "make command found in ~/bin"
fi
if ! [ -f ~/bin/repo ];then
    curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
    chmod a+x ~/bin/repo
else
    echo "repo command found in ~/bin"
fi
