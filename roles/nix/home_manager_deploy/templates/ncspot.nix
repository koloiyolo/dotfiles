{ pkgs, ... }:

{
  home.packages = [
    pkgs.pipewire
  ];

  home.sessionVariables = {
    ALSA_PLUGIN_DIR = "${pkgs.pipewire}/lib/alsa-lib";
  };

  programs.ncspot = {
    enable = true;
  };
}
