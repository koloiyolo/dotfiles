{ pkgs, ... }:

{
  home.packages = [
    pkgs.pipewire
    pkgs.spotifast
  ];

  home.sessionVariables = {
    ALSA_PLUGIN_DIR = "${pkgs.pipewire}/lib/alsa-lib";
  };

  programs.ncspot = {
    enable = true;

    settings = {
      flip_status_indicators = true;
      repeat = "playlist";
      library_tabs = [
        "playlists"
        "albums"
        "artists"
        "podcasts"
        "browse"
      ];
    };
  };
}
