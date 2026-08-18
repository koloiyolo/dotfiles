{ pkgs, ... }:

{
  targets.genericLinux = {
    enable = true;
    gpu.enable = true;
  };

  imports = [
    ./base.nix
    ./zed.nix
    ./ncspot.nix
  ];

  home.packages = [
    pkgs.firefox
    pkgs.vlc
    pkgs.wireshark
    pkgs.nixfmt
  ];
}
