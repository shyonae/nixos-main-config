{ lib, config, ... }:
{
  options = {
    zsh.enable = lib.mkEnableOption "enables zsh";
  };

  config = lib.mkIf config.zsh.enable {
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
          dev-mvn = "nix develop ${flakeDir}/shells/maven/flake.nix -c zsh";
          dev-pwsh = "nix develop ${flakeDir}/shells/powershell/flake.nix -c zsh";
        };

      oh-my-zsh = {
        enable = true;
        plugins = [ "git" "sudo" ];
        theme = "agnoster";
      };
    };
  };
}
