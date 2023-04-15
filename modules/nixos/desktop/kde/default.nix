{ config, lib, pkgs, ... }:

let
  cfg = config.features.desktop;
in
{
  options.features.desktop.kde = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Install KDE Plasma 5 desktop environment";
  };

  config = lib.mkIf cfg.kde {
    services = {
      xserver = {
        enable = true;
        desktopManager.plasma5.enable = true;
        displayManager = {
          sddm.enable = true;
          defaultSession = "plasmawayland";
        };
      };
      pipewire = {
        enable = true;
        alsa.enable = true;
        pulse.enable = true;
        jack.enable = true;
      };
    };

    environment.systemPackages = [ pkgs.helvum ];

    environment.plasma5.excludePackages = with pkgs.plasma5Packages; [
      plasma-browser-integration
      konsole
      elisa
      gwenview
      khelpcenter
      print-manager
    ];

    i18n.inputMethod = {
      enabled = "fcitx5";
      fcitx5.addons = [ pkgs.fcitx5-chinese-addons ];
    };

    environment.sessionVariables = {
      GTK_USE_PORTAL = "true";
    };

    programs.dconf.enable = true;
  };
}
