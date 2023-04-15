{ config, lib, pkgs, ... }:

let
  cfg = config.want;

  cli = { command ? "${pkgs.libsForQt5.kconfig}/bin/kwriteconfig5", rc, args }: (
    lib.concatMapStringsSep " \n" (arg: "${command} --file ${rc} ${arg}") args
  );

  args = { g, k, v ? "", del ? false }:
    let
      getG = x: lib.concatMapStringsSep " " (i: "--group '${i}'") g;
      getV = x: if del then "--delete" else v;
    in
    "${getG g} --key ${k} ${getV v}";

  new = g: k: v: args { inherit g k v; };

  del = g: k: args { inherit g k; del = true; };

  settings = {

    "kded5rc" = [
      (new [ "Module-freespacenotifier" ] "autoload" "false")
      (new [ "Module-networkstatus" ] "autoload" "false")
      (new [ "Module-plasma_accentcolor_service" ] "autoload" "false")
      (new [ "Module-proxyscout" ] "autoload" "false")
      (new [ "Module-colorcorrectlocationupdater" ] "autoload" "false")
      (new [ "Module-kded_touchpad" ] "autoload" "false")
      (new [ "Module-ksysguard" ] "autoload" "false")
    ];

    "plasmashellrc" = [
      (new [ "PlasmaViews" "Panel 2" ] "panelOpacity" "2")
      (new [ "PlasmaViews" "Panel 2" ] "panelVisibility" "1")
    ];

    "kwinrc" = [
      (new [ "Input" ] "TabletMode" "off")
      (new [ "Plugins" ] "zoomEnabled" "false")
      (new [ "Plugins" ] "tileseditorEnabled" "false")
      (new [ "Plugins" ] "blurEnabled" "false")
      (new [ "Desktops" ] "Name_1" "Main")
    ];

    "kdeglobalsrc" = [
      (new [ "General" ] "UseSystemBell" "true")
    ] ++ lib.optionals cfg.kitty [
      (new [ "General" ] "TerminalApplication" "kitty")
      (new [ "General" ] "TerminalApplicationService" "kitty.desktop")
    ] ++ lib.optionals cfg.alacritty [
      (new [ "General" ] "TerminalApplication" "alacritty")
      (new [ "General" ] "TerminalApplicationService" "Alacritty.desktop")
    ];

    "systemsettingsrc" = [
      (new [ "systemsettings_sidebar_mode" ] "HighlightNonDefaultSettings" "true")
    ];

    "powermanagementprofilesrc" = [
      (del [ "AC" "SuspendSession" ] "idleTime")
      (del [ "AC" "SuspendSession" ] "suspendThenHibernate")
      (del [ "AC" "SuspendSession" ] "suspendType")
    ];

    "ksplashrc" = [
      (new [ "KSplash" ] "Engine" "None")
      (new [ "KSplash" ] "Theme" "None")
    ];

    "kactivitymanagerd-statsrc" = [
      (new [ "Favorites-org.kde.plasma.kickoff.favorites.instance-3-global" ] "ordering" "firefox.desktop")
    ];

    "kactivitymanagerd-pluginsrc" = [
      (new [ "Plugin-org.kde.ActivityManager.Resources.Scoring" ] "what-to-remember" "1")
    ];

    "kactivitymanagerdrc" = [
      (new [ "Plugins" ] "org.kde.ActivityManager.ResourceScoringEnabled" "false")
    ];

    "breezerc" = [
      (new [ "Common" ] "ShadowSize" "ShadowSmall")
      (new [ "Common" ] "ShadowStrength" "128")
      (new [ "Style" ] "MenuOpacity" "75")
    ];

    "dolphinrc" = [
      (new [ "PlacesPanel" ] "IconSize" "32")
      (new [ "DetailsMode" ] "IconSize" "32")
      (new [ "PreviewSettings" ] "Plugins" "svgthumbnail")
    ];

    "plasma-org.kde.plasma.desktop-appletsrc" = [
      (new [ "Containments" "2" "Applets" "5" "Configuration" "General" ] "launchers" "preferred://filemanager")
    ];
  };

  commands = (lib.concatLines (
    lib.mapAttrsToList (rc: args: cli { inherit rc args; }) settings
  ));
in
{
  home.activation = {
    kdeSettings = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      XDG_CFG=${config.home.homeDirectory}/.config/

      if [ ! -d $XDG_CFG ]; then
        mkdir $XDG_CFG
      fi

      cd $XDG_CFG

      ${commands}
    '';
  };

  programs.zsh.shellAliases.kwin-dbg = "qdbus org.kde.KWin /KWin org.kde.KWin.showDebugConsole";
}
