{ config, pkgs, ... }:

{
  services.flatpak.enable = true;

  services.flatpak.packages = [
    "org.signal.Signal"
  ];
}