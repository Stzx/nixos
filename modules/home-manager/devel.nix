{ pkgs, ... }:

{
  home.packages = [ pkgs.croc ];

  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
    config.global.warn_timeout = "30s";
  };

  home.file = {
    ".cargo/config.toml".text = ''
      [source.crates-io]
      replace-with = 'ustc'

      [source.ustc]
      registry = "sparse+https://mirrors.ustc.edu.cn/crates.io-index/"

      [build]
      rustc-wrapper = "${pkgs.sccache}/bin/sccache"
    '';
  };
}
