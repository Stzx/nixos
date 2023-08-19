{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [ neofetch ];

  xdg.enable = true;

  fonts.fontconfig.enable = true;

  programs.home-manager.enable = true;

  programs.git.extraConfig = {
    init = {
      defaultBranch = "main";
    };
    fetch = {
      prune = true;
      pruneTags = true;
    };
    pull = {
      rebase = true;
    };
    push = {
      autoSetupRemote = true;
    };
    protocol = {
      file.allow = "always";
    };
  };

  want = {
    zsh = true;

    kitty = true;

    firefox = true;

    nvim = true;
  };
}
