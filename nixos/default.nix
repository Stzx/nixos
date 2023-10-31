{ lib, pkgs, ... }:

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

  hardware.firmware = with pkgs; [
    linux-firmware
    alsa-firmware
    sof-firmware
  ];

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
    extraConfig = "DefaultTimeoutStopSec=60s";
    network.wait-online.anyInterface = true;
  };

  networking.firewall.extraPackages = with pkgs; [
    bind
    radvd
  ];

  documentation.doc.enable = false;

  environment = {
    systemPackages = with pkgs; [
      smartmontools
      acpitool
      nvme-cli
      pciutils
      usbutils

      lsof
      tree
      file

      gptfdisk
      graphviz
      p7zip
    ];
    shellAliases = lib.mkForce {
      npdc = "nix profile diff-closures --profile /nix/var/nix/profiles/system";

      rb = "time sudo nixos-rebuild boot --flake \"$_FLAKE?submodules=1#$(hostname)\"";

      rs = "time sudo nixos-rebuild switch --flake \"$_FLAKE?submodules=1#$(hostname)\"";

      rh = "time home-manager switch --flake \"$_FLAKE?submodules=1#$USER@$(hostname)\"";

      ih = "time nix run home-manager -- switch --flake \"$_FLAKE?submodules=1#$USER@$(hostname)\"";
    };
  };

  environment.etc."gai.conf".text = ''
    precedence ::ffff:0:0/96 100
  '';

  programs.git.enable = true;

  programs.gnupg.agent = {
    enable = true;
    pinentryFlavor = "curses";
  };

  programs.htop = {
    enable = true;
    settings = {
      show_thread_names = true;
      show_merged_command = true;
      shadow_other_users = true;
      highlight_base_name = true;
      highlight_threads = true;
      highlight_changes = true;
      tree_view = true;
      tree_view_always_by_pid = true;
    };
  };
}
