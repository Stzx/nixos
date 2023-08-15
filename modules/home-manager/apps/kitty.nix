{ config, lib, pkgs, dotsPath, ... }:

let
  cfg = config.want;
in
{
  options.want.kitty = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Install kitty terminal emulator";
  };

  config = lib.mkDesktopCfg cfg.kitty [
    {
      programs.kitty = {
        enable = true;
        theme = "Monokai";
        extraConfig = ''
          font_family Iosevka Comfy Wide Motion

          background_opacity 0.8

          cursor_shape underline

          tab_bar_align center
          tab_bar_edge top

          shell_integration no-cursor

          allow_remote_control no
          
          ${lib.optionalString cfg.zsh "shell ${config.programs.zsh.package}/bin/zsh"}
        '';
      };
    }
  ];
}
