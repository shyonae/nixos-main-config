{ lib, config, ... }:
{
  options = {
    git.enable = lib.mkEnableOption "enables git";
  };

  config = lib.mkIf config.git.enable {
    programs.git = {
      enable = true;
      userName = "shyonae";
      userEmail = "scionae@gmail.com";
      aliases = {
        co = "checkout";
        br = "branch";
        ci = "commit";
        cl = "clone";
        st = "status";
        p = "pull";
        pr = "pull --rebase";

        r = "reset";
        r1 = "reset HEAD^";
        r2 = "reset HEAD^^";
        rh = "reset --hard";
        rh1 = "reset HEAD^ --hard";
        rh2 = "reset HEAD^^ --hard";

        # one-line log;
        # ''\ is used to escape characters
        ld = "log --pretty=format:''\"%C(yellow)%h\\ %ad%Cred%d\\ %Creset%s%Cblue\\ [%cn]''\" --decorate --date=relative";
        lds = "log --pretty=format:''\"%C(yellow)%h\\ %ad%Cred%d\\ %Creset%s%Cblue\\ [%cn]''\" --decorate --date=short";
        ll = "log --pretty=format:''\"%C(yellow)%h%Cred%d\\ %Creset%s%Cblue\\ [%cn]''\" --decorate --numstat";
        ls = "log --pretty=format:''\"%C(yellow)%h%Cred%d\\ %Creset%s%Cblue\\ [%cn]''\" --decorate";
        lnc = "log --pretty=format:''\"%h\\ %s\\ [%cn]''\"";
        le = "log --oneline --decorate";

        # Show the history of a file, with diffs;
        filelog = "log -u";
        fl = "log -u";

        # Show modified files in last commit;
        dl = "!git ll -1";

        # Show a diff last commit;
        dlc = "diff --cached HEAD^";

        # Find a file path in codebase - Ex. git f Kubernetes;
        f = "!git ls-files | grep -i";

        # Search/grep your entire codebase for a string - git gr kubernetes;
        grep = "grep -Ii";
        gr = "grep -Ii";

        a = "add";
        ap = "add -p";
        c = "commit --verbose";
        ca = "commit -a --verbose";
        cm = "commit -m";
        cam = "commit -a -m";
        m = "commit --amend --verbose";
        d = "diff";
        ds = "diff --stat";
        dc = "diff --cached";

        s = "status -s";
        cob = "checkout -b";

        # list branches sorted by last modified
        b = "!git for-each-ref --sort='-authordate' --format='%(authordate)%09%(objectname:short)%09%(refname)' refs/heads | sed -e 's-refs/heads/--'";

        # list aliases
        la = "!git config -l | grep alias | cut -c 7-";
      };
    };
  };
}
