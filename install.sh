#!/bin/sh

if [ $# -gt 0 ]
  then
    SCRIPT_DIR=$1
  else
    SCRIPT_DIR="$HOME/nix"
fi

# Generate hardware config for new system
sudo nixos-generate-config --show-hardware-config > $SCRIPT_DIR/system/hardware-configuration.nix

# Check if uefi or bios
if [ -d /sys/firmware/efi/efivars ]; then
    sed -i "0,/bootMode.*=.*\".*\";/s//bootMode = \"uefi\";/" $SCRIPT_DIR/flake.nix
else
    sed -i "0,/bootMode.*=.*\".*\";/s//bootMode = \"bios\";/" $SCRIPT_DIR/flake.nix
    grubDevice=$(findmnt / | awk -F' ' '{ print $2 }' | sed 's/\[.*\]//g' | tail -n 1 | lsblk -no pkname | tail -n 1 )
    sed -i "0,/grubDevice.*=.*\".*\";/s//grubDevice = \"\/dev\/$grubDevice\";/" $SCRIPT_DIR/flake.nix
fi

sudo nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
sudo nix-channel --add https://nixos.org/channels/nixos-unstable nixos
sudo nix-channel --update

# Patch flake.nix with different username/name and remove email by default
sed -i "0,/shyonae/s//$(whoami)/" $SCRIPT_DIR/flake.nix

# Rebuild system
sudo nixos-rebuild switch --flake $SCRIPT_DIR;

# Install and build home-manager configuration
home-manager switch --flake $SCRIPT_DIR;

