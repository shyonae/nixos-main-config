{ config, ... }: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases =
      let
        flakeDir = "~/nix";
      in
      {
        rb = "sudo nixos-rebuild switch --flake ${flakeDir}";
        rbdry = "sudo nixos-rebuild dry-activate --flake ${flakeDir}";
        upd = "sudo nix flake update ${flakeDir}";
        ncl = "sudo nix-channel --list";
        upg = "sudo nixos-rebuild switch --upgrade --flake ${flakeDir}";
        nixgc = "nix-garbage-collect --delete-old";
        nfmt = "nixpkgs-fmt";

        hms = "home-manager switch --flake ${flakeDir}";

        ll = "ls -l";
        v = "nvim";
        se = "sudoedit";
        ff = "fastfetch";
      };

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "sudo" ];
      theme = "agnoster";
    };
  };
}

