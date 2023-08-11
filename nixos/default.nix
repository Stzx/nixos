{ lib, pkgs, secrets, ... }:

let
  inherit (secrets) flake;
in
{
  nix = {
    settings.substituters = [
      "https://mirrors.ustc.edu.cn/nix-channels/store"
      "https://mirror.sjtu.edu.cn/nix-channels/store"
    ];
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    gc = {
      automatic = true;
      dates = "weekly";
      randomizedDelaySec = "3m";
      options = "--delete-older-than 3d";
    };
  };

  boot = {
    loader = {
      timeout = 1;
      efi.canTouchEfiVariables = true;
      systemd-boot = {
        enable = true;
        consoleMode = "max";
      };
    };
    tmp.useTmpfs = true;
  };

  i18n = {
    defaultLocale = "en_US.UTF-8";
    supportedLocales = [
      "en_US.UTF-8/UTF-8"
      "zh_CN.UTF-8/UTF-8"
    ];
  };

  time.timeZone = lib.mkDefault "Asia/Shanghai";

  users.mutableUsers = lib.mkForce false;

  systemd = {
    network.wait-online.extraArgs = [ "--any" ];
    extraConfig = "DefaultTimeoutStopSec=60s";
  };

  networking.firewall.extraPackages = with pkgs; [
    bind
    radvd
  ];

  environment = {
    systemPackages = with pkgs; [
      smartmontools
      nvme-cli
      pciutils
      usbutils

      age
      lsof
      tree
      gptfdisk
      graphviz
      p7zip
    ];
    shellAliases = lib.mkForce {
      re-boot = ''time sudo nixos-rebuild boot --flake "${flake}?submodules=1#$(hostname)" && nix profile diff-closures --profile /nix/var/nix/profiles/system'';

      re-root = ''time sudo nixos-rebuild switch --flake "${flake}?submodules=1#$(hostname)" && nix profile diff-closures --profile /nix/var/nix/profiles/system'';

      re-home = ''time home-manager switch --flake "${flake}?submodules=1#$USER@$(hostname)" && nix profile diff-closures'';

      init-home = ''time nix run home-manager -- switch --flake "${flake}?submodules=1#$USER@$(hostname)"'';
    };
  };

  programs.git.enable = true;

  programs.gnupg.agent = {
    enable = true;
    pinentryFlavor = "curses";
  };

  programs.neovim = {
    enable = true;
    vimAlias = true;
    defaultEditor = true;
    configure = {
      customRC = ''
        set number
        set relativenumber
        set expandtab
      '';
    };
  };

  programs.htop = {
    enable = true;
    settings = {
      show_thread_names = true;
      shadow_other_users = true;
      highlight_base_name = true;
      highlight_threads = true;
      highlight_changes = true;
      tree_view = true;
      tree_view_always_by_pid = true;
    };
  };
}
