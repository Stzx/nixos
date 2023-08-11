{ config, lib, ... }:

{
  imports = [
    ./netdata.nix
  ];

  security.apparmor.enable = lib.mkDefault true;

  security.rtkit.enable = lib.mkDefault true;

  services.dbus = {
    enable = true;
    implementation = lib.mkDefault "broker";
    apparmor = if config.security.apparmor.enable then "enabled" else "disabled"; # broker 还未支持 apparmar, 所以用 enabled
  };
}
