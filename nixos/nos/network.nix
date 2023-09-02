{ lib, ... }:

let
  gateway = [ "192.168.254.254" ];
in
{
  boot.kernel.sysctl = {
    "net.core.default_qdisc" = "cake";

    "net.ipv4.tcp_mtu_probing" = 1;
  };

  networking = {
    useDHCP = lib.mkForce false;
    nftables.enable = true;
    firewall.enable = true;
  };

  systemd.network = {
    enable = true;
    networks = {
      "20-wan" = rec {
        inherit gateway;

        name = "en*";
        address = [ "192.168.254.253/24" ];
        dns = gateway;
        ntp = gateway;
        networkConfig = {
          DHCP = "ipv6";
          IPv6AcceptRA = true;
          DNSSEC = "allow-downgrade";
        };
        ipv6AcceptRAConfig = {
          UseDNS = false;
        };
      };
    };
  };

  networking.timeServers = gateway;

  services = {
    resolved.enable = true;
    timesyncd.enable = true;
  };
}
