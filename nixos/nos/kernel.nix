{ config, lib, pkgs, ... }:

let
  cfg = config.features;

  mkPatchs = args: lib.my.mkPatchs (lib.forEach args (e: e // { origin = ./.; }));
in
{
  boot = {
    kernelPackages = pkgs.linuxPackages_xanmod;
    initrd = {
      includeDefaultModules = false;
      availableKernelModules = [ "nvme" ];
      kernelModules = [ "sha256" ];
    };
    kernelModules = lib.mkForce [ ];
    kernelParams = [ ];
    supportedFilesystems = [ "f2fs" ];
    kernel.sysctl = { };
    kernelPatches = mkPatchs [
      {
        name = "arch";
        suffixes = [ "amd" ];
      }
      { name = "network"; }
      { name = "fs"; }
      { name = "drivers/device"; }
      { name = "drivers/network"; }
      {
        name = "drivers/drm";
        suffixes = [ "nvidia" ];
      }
      { name = "drivers/snd"; }

      { name = "_kernel"; }
    ];
  };

  services.udev.extraRules = ''
    ACTION=="add", KERNEL=="0000:08:00.0", SUBSYSTEM=="pci", RUN:="${pkgs.bash}/bin/bash -c 'echo 1 | tee /sys/bus/pci/devices/0000:08:00.0/remove'"
  '';
}
