{ config, lib, pkgs, secrets, ... }:

{
  imports = [
    ./fs.nix
    ./kernel.nix
    ./network.nix
  ];

  features = {
    cpu.amd = true;
    gpu.nvidia = true;
    desktop.kde = true;
    netdata = true;
  };

  users.extraUsers = {
    "stzx" = {
      uid = 1000;
      isNormalUser = true;
      description = "Silece Tai";
      extraGroups = [ "wheel" "video" "audio" "docker" "keys" "boinc" ];
      initialHashedPassword = secrets.users.stzx;
    };
  };

  services.boinc = {
    enable = true;
    extraEnvPackages = lib.optional config.features.gpu.nvidia config.boot.kernelPackages.nvidia_x11;
  };

  virtualisation.docker = {
    enable = true;
    enableOnBoot = false;
  };
}
