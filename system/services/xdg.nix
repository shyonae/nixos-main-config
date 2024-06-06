{ pkgs, pkgs-stable, userSettings, ... }:
{
  xdg = {
    portal.enable = true;
    # portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

    portal.config.common.default = "*";

    # mimeApps.defaultApplications = {
    #   "text/html" = "${userSettings.browser}.desktop";
    #   "x-scheme-handler/http" = "${userSettings.browser}.desktop";
    #   "x-scheme-handler/https" = "${userSettings.browser}.desktop";
    #   "x-scheme-handler/about" = "${userSettings.browser}.desktop";
    #   "x-scheme-handler/unknown" = "${userSettings.browser}.desktop";
    # };
  };
}
