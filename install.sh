#!/bin/sh

if [[ -z "$1" ]]; then
    echo "Error: You need to provide a file name."
    echo "Usage: $0 <file_name> (without extension)"
    exit 1
fi

if [[ -z $(command -v git) ]]; then
    echo "Git is not installed."
    exit 0
else
    echo "Git is installed."
fi

file_name="$1"
script_path=$(dirname "$(realpath "$0")")
file_path=$(find "$script_path" -name "${file_name}.nix" -print -quit)

if [[ -z "$file_path" ]]; then
    echo "File not found."
    exit 0
else
    parent_dir=$(dirname "$file_path")
    echo "Parent directory of '${file_name}.nix' is: $parent_dir"
fi

hostname_value=$(grep -oP 'hostname\s*=\s*"\K[^"]+' "${parent_dir}/${file_name}.nix")

if [[ -n "$hostname_value" ]]; then
    echo "Hostname: $hostname_value"
else
    echo "Hostname not found."
fi

echo "Generating hardware config..."
sudo nixos-generate-config --show-hardware-config > /etc/nixos/hardware-configuration.nix

is_nixos_unstable_present=$(nix-channel --list | grep -c "nixos")

if [[ "$is_nixos_unstable_present" -eq 0 ]]; then
    echo "NixOS unstable channel not found. Adding..."
    sudo nix-channel --add https://nixos.org/channels/nixos-unstable nixos
elif [[ "$file_name" == *"homelab"* ]]; then
    echo "Homelab detected. NixOS stable channel not found. Adding..."
    sudo nix-channel --add https://nixos.org/channels/nixos-24.05 nixos
else
    echo "NixOS channel is already configured."
fi

echo "Updating channels..."
sudo nix-channel --update

sudo cp "${parent_dir}/flake.nix" /etc/nixos/
sed -i "s|MAIN_DIRECTORY|${script_path}|g" /etc/nixos/flake.nix

echo "Initializing system..."
sudo nixos-rebuild switch --flake /etc/nixos --impure
