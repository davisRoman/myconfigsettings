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


