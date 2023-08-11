{ config, lib, ... }:

{
  imports = [
    ./netdata.nix
  ];

  console = {
    font = "LatGrkCyr-8x16";
    earlySetup = true;
  };

  security.apparmor.enable = lib.mkDefault true;

  security.rtkit.enable = lib.mkDefault true;

  services.dbus = {
    enable = true;
    implementation = lib.mkDefault "broker";
    apparmor = if config.security.apparmor.enable then "enabled" else "disabled"; # broker 还未支持 apparmar, 所以用 enabled
  };
}
