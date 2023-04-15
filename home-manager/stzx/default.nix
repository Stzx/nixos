{ nixos, config, lib, pkgs, ... }:

{
  imports = [
    ./misc.nix
    ../.
  ] ++ lib.optionals lib.my.isKDE [
    ./kde.nix
  ] ++ lib.optionals lib.my.haveAnyDE [
    ./gtk.nix
    {
      home.packages = with pkgs; [
        librecad
        libreoffice
        texlive.combined.scheme-full

        calibre
        obs-studio
        qbittorrent
        telegram-desktop

        mpv
        nomacs
      ];
    }
  ];

  home.packages = with pkgs; [ ffmpeg ];

  want = {
    adb = true;
    scrcpy = true;
    nmap = true;
    secret = true;
  };
}
