#!/bin/sh

if ! java -version  || ! javac -version;then
    echo "java needs to be installed first"
fi

curl -o ~/Downloads http://apache.mirrors.tds.net/incubator/netbeans/incubating-netbeans/incubating-10.0/incubating-netbeans-10.0-bin.zip

unzip -d ~ ~/Downloads/incubating-netbeans-10.0-bin.zip

#binaries are here
#davis@panther ➜  bin ls
#netbeans  netbeans64.exe  netbeans.exe

