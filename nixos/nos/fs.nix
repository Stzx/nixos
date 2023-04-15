{ config, lib, pkgs, secrets, ... }:

let
  inherit (lib.my) nvmeEui btrfsOptions btrfsMountUnit f2fsMountUnit;

  nvme = "${nvmeEui secrets.disks.origin-eui}";

  btrfsUnit = btrfsMountUnit secrets.disks.btrfs;

  f2fsUnit = f2fsMountUnit secrets.disks.f2fs;
in
{
  systemd = {
    mounts = btrfsUnit.mounts ++ f2fsUnit.mounts;
    automounts = btrfsUnit.automounts ++ f2fsUnit.automounts;
  };

  zramSwap.enable = true;

  virtualisation.docker.storageDriver = "btrfs";
} // {
  disko.devices = {
    disk.nvme = {
      type = "disk";
      device = nvme;
      content = {
        type = "gpt";
        partitions = {
          ESP = {
            device = "${nvme}-part1";
            size = "1G";
            type = "EF00";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
            };
          };
          ORIGIN = {
            device = "${nvme}-part2";
            size = "100%";
            content = {
              type = "btrfs";
              extraArgs = [ "--checksum sha256" "-f" ];
              subvolumes = {
                "/${config.networking.hostName}" = {
                  mountpoint = "/";
                  mountOptions = btrfsOptions;
                };
                "/nix" = {
                  mountpoint = "/nix";
                  mountOptions = btrfsOptions;
                };
                "/home" = {
                  mountpoint = "/home";
                  mountOptions = btrfsOptions;
                };
                "/snapshots" = { };
              };
            };
          };
        };
      };
    };
  };
}
