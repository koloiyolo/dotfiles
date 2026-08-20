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
    ./ncspot.nix
  ];

  home.packages = [
    pkgs.firefox
    pkgs.vlc
    pkgs.wireshark
  ];
}
