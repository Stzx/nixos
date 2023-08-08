{ config, lib, pkgs, ... }:

let
  vscodium = pkgs.vscodium-fhsWithPackages (pkgs: with pkgs; [
    nixpkgs-fmt

    python3
  ]);
in
{
  home.packages = [ pkgs.croc ];

  home.file = {
    ".cargo/config.toml".text = ''
      [source.crates-io]
      replace-with = 'ustc'

      [source.ustc]
      registry = "sparse+https://mirrors.ustc.edu.cn/crates.io-index/"

      [build]
      rustc-wrapper = "${pkgs.sccache}/bin/sccache"
    '';
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    config.global.warn_timeout = "30s";
  };

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
}
