{ config, lib, pkgs, ... }:

{
  imports = [ ./kde ];

  config = lib.mkIf lib.my.haveAnyDE {
    fonts = {
      packages = with pkgs; [
        noto-fonts
        noto-fonts-cjk-serif
        noto-fonts-cjk-sans
        noto-fonts-color-emoji

        jetbrains-mono

        material-icons

        iosevka-comfy.comfy
        iosevka-comfy.comfy-motion
        iosevka-comfy.comfy-wide
        iosevka-comfy.comfy-wide-motion

        liberation_ttf
      ];
      fontconfig = {
        enable = true;
        subpixel.rgba = "rgb";
        defaultFonts = lib.mkForce {
          serif = [
            "Noto Serif"
            "Noto Serif CJK SC"
            "Noto Serif CJK TC"
            "Noto Serif CJK JP"
            "Noto Serif CJK KR"
          ];
          sansSerif = [
            "Noto Sans"
            "Noto Sans CJK SC"
            "Noto Sans CJK TC"
            "Noto Sans CJK JP"
            "Noto Sans CJK KR"
          ];
          monospace = [
            "Noto Sans Mono"
            "Noto Sans Mono CJK SC"
            "Noto Sans Mono CJK TC"
            "Noto Sans Mono CJK JP"
            "Noto Sans Mono CJK KR"
          ];
          emoji = [
            "Noto Color Emoji"
          ];
        };
      };
    };
  };
}
