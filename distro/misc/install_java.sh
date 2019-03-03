#!/bin/sh

set -e

sudo add-apt-repository ppa:linuxuprising/java -y

# TODO: automate the YES prompt
sudo apt-get install -y oracle-java11-installer

sudo apt-get install -y oracle-java11-set-default

java  -version
javac -version

if ! grep -q 'export JAVA_HOME=' ~/.zshrc;then
cat << EOF >> ~/.zshrc
export PATH=$PATH:/usr/jdk-11.0.1/bin
export JAVA_HOME=/usr/jdk-11.0.1
export J2SDKDIR=/usr/jdk-11.0.1
EOF
fi
