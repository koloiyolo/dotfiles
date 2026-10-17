{ pkgs, ... }:

{
  home.packages = [
    pkgs.papirus-icon-theme

    pkgs.gnomeExtensions.dash-to-dock
    pkgs.gnomeExtensions.veil
    pkgs.gnomeExtensions.just-perfection
    pkgs.gnomeExtensions.caffeine
    pkgs.gnomeExtensions.clipboard-history
    pkgs.gnomeExtensions.system-monitor
  ];

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      icon-theme = "Papirus";
      color-scheme = "prefer-dark";
    };

    "org/gnome/shell/weather" = {
      automatic-location = true;
    };

    "org/gnome/desktop/wm/preferences" = {
      button-layout = "appmenu:minimize,maximize,close";
    };

    # ##############################
    #           EXTENSIONS
    # ##############################

    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = with pkgs.gnomeExtensions; [
        dash-to-dock.extensionUuid
        veil.extensionUuid
        caffeine.extensionUuid
        just-perfection.extensionUuid
        clipboard-history.extensionUuid
        system-monitor.extensionUuid
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
      custom-theme-shrink = true;
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

  # "org/gnome/shell/extensions/just-perfection" = {
  #   dash-app-running = true;
  #   panel = true;
  #   support-notifier-showed-version = 36;
  #   theme = false;
  # };

  # "org/gnome/shell/extensions/veil" = {
  #   all-items = [
  #     "System stats"
  #     "ClipboardIndicator"
  #     "Stop Screencast"
  #     "Stop Screen Sharing"
  #     "Dwell Click"
  #     "Accessibility"
  #     "Keyboard"
  #   ];
  #   auto-hide-enabled = false;
  #   interaction-mode = "click";
  #   saved-visibility = false;
  # };

}
