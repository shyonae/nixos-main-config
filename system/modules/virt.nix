{ lib, config, pkgs, userSettings, ... }:
{
  options = {
    virt.enable = lib.mkEnableOption "enables virt";
  };

  config = lib.mkIf config.virt.enable {
    programs.dconf.enable = true;

    users.users.${userSettings.username}.extraGroups = [ "libvirtd" ];

    programs.virt-manager.enable = true;

    environment.systemPackages = with pkgs; [
      virt-viewer
      virtiofsd
      spice
      spice-vdagent
      spice-gtk
      spice-protocol
      win-virtio
      win-spice
      gnome.adwaita-icon-theme
    ];

    virtualisation = {
      libvirtd = {
        enable = true;
        qemu = {
          swtpm.enable = true;
          ovmf.enable = true;
          ovmf.packages = [ pkgs.OVMFFull.fd ];
        };
      };
      spiceUSBRedirection.enable = true;
    };

    services.qemuGuest.enable = true;
    services.spice-vdagentd.enable = true;
  };
}
