{ pkgs, ... }:

let
  inherit (pkgs) mkShell buildFHSEnv;

  llvm = pkgs.llvmPackages_latest;

  noCCShell = mkShell.override { stdenv = pkgs.stdenvNoCC; };

  llvmShell = mkShell.override { inherit (llvm) stdenv; };

  idea = pkgs.jetbrains.idea-community.override {
    vmopts = ''
      -Xms3072m
      -Xmx6144m
      -XX:ReservedCodeCacheSize=1024m
      -XX:MaxMetaspaceSize=1024m
      -Dsun.java2d.xrender=True
    '';
  };

  fhs = buildFHSEnv {
    name = "fhs";
    runScript = "zsh";
    targetPkgs = pkgs: with pkgs;[
      idea

      temurin-bin-17

      python3

      rustup

      cargo-asm
      cargo-bloat
      cargo-cross
      cargo-deps
      cargo-expand
      cargo-wasi

      wasm-tools
      wit-bindgen
    ];
  };
in
{
  default = llvmShell {
    packages = with pkgs;[
      lld
      lldb

      sqlite

      graphviz

      fhs
    ];

    nativeBuildInputs = with pkgs; [ pkg-config ];

    buildInputs = with pkgs; [
      llvm.libclang

      pipewire
    ];
  };

  kernel = mkShell {
    packages = with pkgs; [
      flex
      bison
    ];

    nativeBuildInputs = with pkgs; [ pkg-config ];

    buildInputs = with pkgs; [ ncurses ];
  };
}
