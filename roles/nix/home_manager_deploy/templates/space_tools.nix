{ pkgs, ... }:

{
  home.packages = [

    (pkgs.callPackage (pkgs.fetchFromGitHub {
      owner = "koloiyolo";
      repo = "ccsds_parsers";
      rev = "2c99d9a7d16dda71b2abb07c21e0e17036deb58e";
      hash = "sha256-UniyuBBiarAcvITvO577GjEUXhDdcU1dB9AqNRlBus0=";
    }) { })
  ];
}
