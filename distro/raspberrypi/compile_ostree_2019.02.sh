#!/bin/bash

sudo apt-get install libtool-bin libattr1-dev libglib2.0-dev libgsystem-dev liblzma-dev e2fslibs-dev autoconf bison libgpgme-dev libfuse-dev autoconf

git clone https://github.com/cgwalters/ostree.git -b delta-dump-filename

autogen.sh

make 
