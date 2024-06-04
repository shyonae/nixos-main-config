How-To use:

```bash
ssh-keygen # add the .pub key in the github settings
nix-shell -p git --command "git clone git@github.com:shyonae/nixos-main-config.git ~/nix"
cd ~/nix
./install.sh
```
Credit for the base template goes to librephoenix's repo [here](https://github.com/librephoenix/nixos-config).

<!-- nix-shell -p git --command "nix run --experimental-features 'nix-command flakes' github:shyonae/nixos-main-config" -->