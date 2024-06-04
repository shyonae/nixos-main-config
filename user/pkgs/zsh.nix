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
        ncl = "sudo nix-channel --list";
        nixgc = "nix-collect-garbage --delete-old";
        format = "nixpkgs-fmt";

        ll = "ls -lah";
        se = "sudoedit";
        v = "nvim";
        ff = "fastfetch";
      };

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "sudo" ];
      theme = "agnoster";
    };
  };
}

