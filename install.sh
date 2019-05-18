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
echo "  ___      _______  _______    _______  __   __  _______    __    _  _______  _     _   __ "
echo " |   |    |       ||       |  |       ||  | |  ||       |  |  |  | ||       || | _ | | |  |"
echo " |   |    |   _   ||    ___|  |   _   ||  | |  ||_     _|  |   |_| ||   _   || || || | |  |"
echo " |   |    |  | |  ||   | __   |  | |  ||  |_|  |  |   |    |       ||  | |  ||       | |  |"
echo " |   |___ |  |_|  ||   ||  |  |  |_|  ||       |  |   |    |  _    ||  |_|  ||       | |__|"
echo " |       ||       ||   |_| |  |       ||       |  |   |    | | |   ||       ||   _   |  __ "
echo " |_______||_______||_______|  |_______||_______|  |___|    |_|  |__||_______||__| |__| |__|"
echo ""
echo "******************************************************************************************************************"
echo "p.s. since you haven't automated this yet, don't forget to set ZSH_THEME=\"powerlevel9k/powerlevel9k\" in ~/.zshrc"
echo "******************************************************************************************************************"
