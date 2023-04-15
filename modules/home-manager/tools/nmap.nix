{ config, lib, pkgs, ... }:

{
  options.want.nmap = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Install Nmap";
  };

  config = lib.mkIf config.want.nmap {
    home.packages = [ pkgs.nmap ];

    programs.zsh.shellAliases = {
      nmap-geo = "sudo nmap -n -sn -Pn --traceroute --script traceroute-geolocation";
      nmap-kml = "sudo nmap -n -sn -Pn --traceroute --script traceroute-geolocation --script-args traceroute-geolocation.kmlfile=/tmp/geo.kml";
    };
  };
}
