{ config, lib, pkgs, ... }:

let
  cfg = config.features;

  netdata = pkgs.netdata.override {
    withCups = false;
    withDBengine = false;
    withIpmi = false;
    withCloud = false;
    withConnPubSub = false;
    withConnPrometheus = false;
    withSsl = false;
  };
in
{
  options.features = {
    netdata = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Install NETDATA";
    };
  };

  config = lib.mkIf cfg.netdata {
    services.netdata = {
      enable = true;
      package = netdata;
      python.enable = false;
      config = {
        db.mode = "ram";
        plugins = {
          "diskspace" = "no";
          "cgroups" = "no";
          "debugfs" = "no";
          "nfacct" = "no";
          "go.d" = "no";
          "statsd" = "no";
          "python.d" = "no";
          "apps" = "no";
          "freeipmi" = "no";
          "perf" = "no";
        };
      };
    };

    # FIXME: https://github.com/NixOS/nixpkgs/pull/244789
    systemd.services.netdata.serviceConfig.ExecStartPost = lib.mkForce (pkgs.writeShellScript "wait-for-netdata-up" ''
      while [ ! -e "$NETDATA_PIPENAME" ] || [ "$(${netdata}/bin/netdatacli ping)" != "pong" ]; do sleep 0.5; done
    '');
  };
}
