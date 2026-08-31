{ pkgs, ... }:

{
  home.packages = [

    (pkgs.callPackage (pkgs.fetchFromGitHub {
      owner = "koloiyolo";
      repo = "ccsds_parsers";
      rev = "b19e315ade91bc0ae1a4b3bc3fe41c65809a1455";
      hash = "sha256-n7S4PQ7li+Wm5Tm6KUULAPqVytM7TgRMexhCOpb/GaM=";
    }) { })
  ];
}
