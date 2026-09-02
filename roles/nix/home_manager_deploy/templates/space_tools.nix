{ pkgs, ... }:

{
  home.packages = [

    (pkgs.callPackage (pkgs.fetchFromGitHub {
      owner = "koloiyolo";
      repo = "ccsds_parsers";
      rev = "ae8d276f2bb48984c880452da12ea4e8fd34d1a7";
      hash = "sha256-c9kgpjyDfmKGVirgH8dOYhtk+zI+VRlYaYtz5XpB6Gg=";
    }) { })
  ];
}
