{ pkgs, pkgs-stable, ... }: {
  programs.zsh.enable = true;

  users = {
    defaultUserShell = pkgs.zsh;

    users.shyonae = {
      isNormalUser = true;
      description = "Main user";
      extraGroups = [ "networkmanager" "wheel" "input" ];
      packages = with pkgs; [
        # unstable packages here
      ];
    };
  };

  # Enable automatic login for the user.
  services.getty.autologinUser = "shyonae";
}

