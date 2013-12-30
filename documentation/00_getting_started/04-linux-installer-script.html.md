```
title: "Install on Linux"
```

Please review this script for a custom install or run this as a usual bash script on your system. It has been used successfully on x64 Ubuntu distributions. Note that it will compile haxe and neko on your system.

```
#!/bin/bash

#Install Haxe3 dev, Neko and OpenFL on Ubuntu x64
#Warning this does not work on x32 linux

#based on help from Jason O'Neil's script

# Die function, Taken from http://stackoverflow.com/questions/64786/error-handling-in-bash
function f
{
    PROGNAME=$(basename $0)
    echo "${PROGNAME}: ${1:-"Unknown Error"}" 1>&2
    exit 1
}

###

echo ""
echo "Creating 'haxeinstall' directory..."
mkdir -p haxeinstall || error_exit "Failed to create 'haxeinstall' directory."
cd haxeinstall

###

echo ""
echo "Installing dependencies for Haxe and Neko with apt-get. "
echo "We will need your password..."

sudo apt-get install libzip-dev ocaml subversion libgc-dev libpcre3-dev -y || error_exit "ERROR: Failed to install dependencies with apt-get"

###

echo ""
echo "About to checkout, compile and install Haxe GIT"
read -p "Press Enter to continue"

echo "Checkout Haxe 3.00 code"
rm -Rf haxe
git clone -b development https://github.com/HaxeFoundation/haxe.git || error_exit "Failed to checkout haxe source"
cd haxe
git submodule init
git submodule update

echo "Compile Haxe"
make clean all || error_exit "Failed to run 'make clean all' on haxe codebase"
echo "Install Haxe"
sudo make install || error_exit "Failed to run 'sudo make install' on haxe codebase"
cd ..

haxe 

echo ""
echo "Haxe Installed"

###

echo ""
echo "About to checkout, compile and install Neko GIT"
echo "You may have to press 's' a few times to skip optional extra things."
read -p "Press Enter to continue"

echo "Checkout Neko 2.0 code"
rm -Rf neko
git clone https://github.com/HaxeFoundation/neko.git || error_exit "Failed to checkout neko source"

echo "Compile Neko"
cd neko
make clean all || error_exit "Failed to run 'make clean all' on neko codebase"
echo "Install Neko"
sudo make install || error_exit "Failed to run 'sudo make install' on neko codebase"
cd ..x

neko

echo ""
echo "Neko Installed..."

###

echo ""
echo "Putting HAXEPATH and NEKOPATH in your ~/.bashrc..."

echo "export HAXEPATH=/usr/lib/haxe" >> ~/.bashrc
echo "export NEKOPATH=/usr/lib/neko" >> ~/.bashrc

###

echo ""
echo "Haxelib setup" || error_exit "Failed to setup haxelib"

haxelib setup
haxelib selfupdate

###
echo "Install OpenFL"
haxelib install openfl
haxelib run openfl setup

cd ..
echo "Type [haxe], [neko], [haxelib], [openfl] and [haxedoc] at a command line to check they're good to go"

```