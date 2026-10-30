{ config, pkgs, ... }:

{
  targets.genericLinux = {
    enable = true;
    gpu.enable = true;
  };
  systemd.user.sessionVariables.PATH = "${config.home.profileDirectory}/bin:$PATH";

  imports = [
    ./base.nix
    ./zed.nix
    ./spotify.nix
    ./space_tools.nix
    ./gnome.nix
    ./ghostty.nix
    ./firefox.nix
  ];

  home.packages = [
    pkgs.vlc
    pkgs.wireshark
  ];
}
