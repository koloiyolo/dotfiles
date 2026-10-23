{ pkgs, ... }:

{
  services.tailscale.enable = true;

  environment.systemPackages = [ pkgs.tailscale ];

  networking.firewall.allowedUDPPorts = [ 41641 ];
}
