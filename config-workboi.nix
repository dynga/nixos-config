# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  networking.hostName = "workboi"; # Define your hostname.

  Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

}
