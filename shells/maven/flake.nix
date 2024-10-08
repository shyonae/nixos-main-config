{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }@inputs:
    let
      supportedSystems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      forEachSupportedSystem = inputs.nixpkgs.lib.genAttrs supportedSystems;
      nixpkgsFor = forEachSupportedSystem (system: import inputs.nixpkgs { inherit system; });
    in
    {
      devShells = forEachSupportedSystem (system:
        let
          pkgs = nixpkgsFor.${system};
        in
        {
          default = pkgs.mkShell {

            shellHook = ''
              echo "MAVEN DEV SHELL" | ${pkgs.lolcat}/bin/lolcat
            '';

            packages = with pkgs; [
              maven
              openjdk11
            ];
          };
        });
    };
}
