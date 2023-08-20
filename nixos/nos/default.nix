{ secrets, ... }:

{
  imports = [
    ./kernel

    ./fs.nix
    ./network.nix
    ./misc.nix
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
}
