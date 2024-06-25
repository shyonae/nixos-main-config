{ lib, config, userSettings, ... }:
{
  options = {
    docker.enable = lib.mkEnableOption "enables docker";
  };

  config = lib.mkIf config.docker.enable {
    virtualisation.docker.enable = true;
    users.users.${userSettings.username}.extraGroups = [ "docker" ];
  };
}
