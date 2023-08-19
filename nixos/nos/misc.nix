{ config, lib, ... }:

{
  nix.daemonCPUSchedPolicy = "idle";

  services.boinc.extraEnvPackages = lib.optional config.features.gpu.nvidia config.boot.kernelPackages.nvidia_x11;

  virtualisation.docker = {
    enable = true;
    enableOnBoot = false;
  };
}
