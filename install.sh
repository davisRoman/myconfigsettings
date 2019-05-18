#!/usr/bin/env bash

set -e

echo ">>>> Customizing debian-based distro <<<<"
echo ""
pushd distro
   ./install.sh
popd

echo ">>>> Customizing vim <<<<"
echo ""
pushd vim
   ./install.sh
popd
echo "  ___      _______  _______    _______  __   __  _______    __    _  _______  _     _ "
echo " |   |    |       ||       |  |       ||  | |  ||       |  |  |  | ||       || | _ | |"
echo " |   |    |   _   ||    ___|  |   _   ||  | |  ||_     _|  |   |_| ||   _   || || || |"
echo " |   |    |  | |  ||   | __   |  | |  ||  |_|  |  |   |    |       ||  | |  ||       |"
echo " |   |___ |  |_|  ||   ||  |  |  |_|  ||       |  |   |    |  _    ||  |_|  ||       |"
echo " |       ||       ||   |_| |  |       ||       |  |   |    | | |   ||       ||   _   |"
echo " |_______||_______||_______|  |_______||_______|  |___|    |_|  |__||_______||__| |__|"


