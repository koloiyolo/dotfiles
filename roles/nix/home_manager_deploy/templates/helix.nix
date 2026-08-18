{ pkgs, ... }:

let
  dev_tools = import ./dev_tools.nix { inherit pkgs; };
in
{
  home.packages = dev_tools ++ [
    pkgs.wl-clipboard
  ];

  programs.helix = {
    enable = true;
    settings.theme = "nord";
  };
}
