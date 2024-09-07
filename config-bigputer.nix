# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  networking.hostName = "bigputer"; # Define your hostname.

  users = {
    users = {
      niko = {
        description = "Nikola Arlotti";
        home = "/home/niko";
        extraGroups = [ "wheel" "networkmanager" ];
        isNormalUser = true;
        password = "changeme";
      };
    };
  };

    programs = {
      firefox.enable = true;
      steam.enable = true;
      gamemode.enable = true;
      lutris.enable = true;
    };
}
