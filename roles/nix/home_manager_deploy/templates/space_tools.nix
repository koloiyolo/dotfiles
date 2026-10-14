{ pkgs, ... }:

{
  home.packages = [

    (pkgs.callPackage (pkgs.fetchFromGitHub {
      owner = "koloiyolo";
      repo = "ccsds_parsers";
      rev = "e92e2a33263a4a8ffbb149f569e91140b49d0e04";
      hash = "sha256-PcIy7N0gzvssKNV1C0pD6kOyCaSfjNT8sml3c2POXYk=";
    }) { })
  ];
}
