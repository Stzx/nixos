{ config, lib, pkgs, dotsPath, ... }:

let
  cfg = config.want;
in
{
  options.want.alacritty = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Install alacritty terminal emulator";
  };

  config = lib.mkDesktopCfg cfg.alacritty [
    {
      home.packages = [ pkgs.alacritty ];

      xdg.configFile = {
        "alacritty/theme.yml".source = dotsPath + /alacritty/alacritty-theme/themes/monokai_charcoal.yaml;
        "alacritty/alacritty.yml".text = ''
          import:
            - ~/.config/alacritty/theme.yml

          window:
            dimensions:
              columns: 160
              lines: 32
            opacity: 0.75
            startup_mode: Maximized

          cursor:
            style:
              shape: Underline
              blinking: On
          ${lib.optionalString cfg.zsh ''
          shell:
            program: ${config.programs.zsh.package}/bin/zsh
          ''}

          key_bindings:
              - { key: N, mods: Control, action: CreateNewWindow }
              - { key: C, mods: Control|Shift, action: Copy }
              - { key: V, mods: Control|Shift, action: Paste }
        '';
      };
    }
  ];
}
