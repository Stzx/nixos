{ config, lib, secrets, ... }:

let
  inherit (secrets.network) IP HOP proxy noProxy;

  envVars = {
    HTTP_PROXY = proxy;
    HTTPS_PROXY = proxy;
    NO_PROXY = noProxy;
  };
in
{
  nix = { inherit envVars; };

  systemd.services.docker.environment = envVars;

  boot.kernel.sysctl = {
    "net.core.default_qdisc" = "cake";

    "net.ipv4.tcp_mtu_probing" = 1;
  };

  networking = {
    useDHCP = lib.mkForce false;
    extraHosts = ''
    '';
    nftables.enable = true;
    firewall = {
      enable = true;
    };
  };

  systemd.network = {
    enable = true;
    networks = {
      "20-wan" = {
        name = "en*";
        address = lib.singleton "${IP}/24";
        gateway = HOP;
        dns = HOP;
        ntp = HOP;
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

  networking.timeServers = HOP;

  services = {
    resolved.enable = true;
    timesyncd.enable = true;
  };
}
