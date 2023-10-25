{ lib, pkgs, ... }:

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
        calibre
        librecad
        libreoffice

        texlive.combined.scheme-full
        texstudio

        mpv
        nomacs
        obs-studio
        qbittorrent
        telegram-desktop

        ffmpeg
        wireshark
      ];
    }
  ];

  want = {
    adb = true;
    nmap = true;
    secret = true;
  };
}
