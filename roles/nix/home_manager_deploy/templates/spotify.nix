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

  # `spotifast` doesn't expose the configuration via home-manager yet
  # https://search.nixos.org/options?channel=unstable&query=spotifast&source=home_manager&type=options
  #
  #   programs.spotifast = {
  #     enable = true;
  #
  #     settings = {
  #       bitrate = 320;
  #       normalisation = false;
  #       audio_cache_mb = 4096;
  #
  #       theme = "system";
  #       player_bar_vis = "spectrum";
  #       check_for_updates = "false";
  #     };
  #   };
}
