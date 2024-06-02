{ config, ... }: {
    programs.zsh = {
        enable = true;
        enableCompletion = true;
        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;

        shellAliases =
        let
            flakeDir = "~/nix";
        in {
            rb = "sudo nixos-rebuild switch --flake ${flakeDir}";
            upd = "nix flake update ${flakeDir}";
            ncl = "sudo nix-channel --list";
            upg = "sudo nixos-rebuild switch --upgrade --flake ${flakeDir}";
            ngc = "nix-collect-garbage --delete-old";

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

