{ config, pkgs, lib, ... }:

let
  cfg = config.want;

  # FIXME: https://github.com/veracrypt/VeraCrypt/issues/952
  veracrypt = pkgs.veracrypt.overrideAttrs (_: prev: {
    installPhase = builtins.replaceStrings
      [ "Exec=$out/bin/veracrypt" ]
      [ "Exec=env WXSUPPRESS_SIZER_FLAGS_CHECK=1 $out/bin/veracrypt" ]
      prev.installPhase;
  });
in
{
  options.want.secret = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Install secret";
  };

  config = lib.mkDesktopCfg cfg.secret [
    {
      home.packages = [
        veracrypt

        pkgs.keepassxc
      ];
    }
  ];
}
