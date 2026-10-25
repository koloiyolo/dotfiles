{ pkgs, ... }:

{
  home.packages = with pkgs; [
    papirus-icon-theme
    gnomeExtensions.dash-to-dock
    gnomeExtensions.just-perfection
    gnomeExtensions.blur-my-shell
    gnomeExtensions.caffeine
    gnomeExtensions.clipboard-history
    gnomeExtensions.system-monitor
    gnomeExtensions.status-tray
  ];

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      icon-theme = "Papirus-Dark";
      color-scheme = "prefer-dark";
      accent-color = "slate";
      clock-format = "24h";
      clock-show-seconds = true;
      clock-show-weekday = true;
      enable-animations = true;
      gtk-im-module = "";
      show-battery-percentage = true;
      toolkit-accessibility = false;
    };

    "org/gnome/shell/weather" = {
      automatic-location = true;
    };

    "org/gnome/desktop/wm/preferences" = {
      button-layout = "appmenu:minimize,maximize,close";
    };

    "org/gtk/gtk4/settings/file-chooser" = {
      show-hidden = true;
      sort-directories-first = true;
    };

    # ##############################
    #           EXTENSIONS
    # ##############################

    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = with pkgs.gnomeExtensions; [
        dash-to-dock.extensionUuid
        caffeine.extensionUuid
        just-perfection.extensionUuid
        clipboard-history.extensionUuid
        system-monitor.extensionUuid
        blur-my-shell.extensionUuid
        status-tray.extensionUuid
      ];
    };

    "org/gnome/shell/extensions/window-list" = {
      display-all-workspaces = false;
    };

    "org/gnome/shell/extensions/dash-to-dock" = {
      always-center-icons = true;
      apply-custom-theme = false;
      apply-glossy-effect = false;
      background-opacity = 0.80000000000000004;
      custom-theme-customize-running-dots = false;
      custom-theme-running-dots-border-color = "rgb(255,255,255)";
      custom-theme-running-dots-color = "rgb(255,255,255)";
      custom-theme-shrink = false;
      dash-max-icon-size = 48;
      dock-fixed = true;
      dock-position = "LEFT";
      extend-height = true;
      height-fraction = 1.0;
      hide-tooltip = false;
      icon-size-fixed = true;
      multi-monitor = true;
      preview-size-scale = 0.0;
      running-indicator-style = "DOTS";
      show-apps-at-top = false;
      show-show-apps-button = true;
      transparency-mode = "DEFAULT";
      unity-backlit-items = false;
    };
  };
}
