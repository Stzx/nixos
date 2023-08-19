{ config, lib, pkgs, dotsPath, ... }:

let
  cfg = config.want;

  vscodium = pkgs.vscodium-fhsWithPackages (pkgs: with pkgs; [
    nixpkgs-fmt

    python3
  ]);
in
{
  options.want.vscodium = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Install VSCodium";
  };

  config = lib.mkIf cfg.vscodium {
    programs.vscode = {
      enable = true;
      package = vscodium;
      enableUpdateCheck = false;
      enableExtensionUpdateCheck = false;
      mutableExtensionsDir = false;
      extensions = with pkgs.vscode-extensions; [
        pkief.material-icon-theme
        vscodevim.vim

        ms-python.python
        ms-python.vscode-pylance

        jnoortheen.nix-ide

        james-yu.latex-workshop
      ];
      userSettings = {
        "workbench.colorTheme" = "Monokai";
        "workbench.iconTheme" = "material-icon-theme";

        "editor.fontFamily" = "'JetBrains Mono', 'Droid Sans Mono', 'monospace', monospace";
        "editor.cursorStyle" = "underline";
        "editor.formatOnSave" = true;
        "editor.renderWhitespace" = "all";
        "editor.cursorSmoothCaretAnimation" = "explicit";

        "files.enableTrash" = false;
        "files.autoSave" = "onFocusChange";

        "python.languageServer" = "Pylance";
      } // lib.optionalAttrs config.want.zsh {
        "terminal.integrated.defaultProfile.linux" = "zsh";
      };
    };
  };
}
