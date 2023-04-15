{ config, lib, pkgs, ... }:

{
  imports = [ ./kde ];

  config = lib.mkIf lib.my.haveAnyDE {
    fonts = {
      packages = with pkgs; [
        source-han-serif
        source-han-sans
        source-han-mono

        noto-fonts
        noto-fonts-cjk-serif
        noto-fonts-cjk-sans
        noto-fonts-emoji

        material-icons

        jetbrains-mono
      ];
      fontconfig = {
        enable = true;
        subpixel.rgba = "rgb";
        defaultFonts = lib.mkForce {
          serif = [
            "Noto Serif CJK SC"
            "Noto Serif CJK TC"
            "Noto Serif CJK JP"
            "Noto Serif"

            "Source Han Serif SC"
            "Source Han Serif TC"
            "Source Han Serif K"
            "Source Han Serif"
          ];
          sansSerif = [
            "Noto Sans CJK SC"
            "Noto Sans CJK TC"
            "Noto Sans CJK JP"
            "Noto Sans"

            "Source Han Sans SC"
            "Source Han Sans TC"
            "Source Han Sans K"
            "Source Han Sans"
          ];
          monospace = [
            "Noto Sans Mono CJK SC"
            "Noto Sans Mono CJK TC"
            "Noto Sans Mono CJK JP"
            "Noto Sans Mono"

            "Source Han Mono SC"
            "Source Han Mono TC"
            "Source Han Mono K"
            "Source Han Mono"
          ];
          emoji = [
            "Noto Color Emoji"
          ];
        };
      };
    };
  };
}
