How-To use:

```bash
ssh-keygen # add the .pub key in the github settings
nix-shell -p git --command "git clone git@github.com:shyonae/nixos-main-config.git ~/nix"
cd ~/nix
./install.sh
```
