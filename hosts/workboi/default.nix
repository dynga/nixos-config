# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs,  ... }:

{

 imports =
   [ # Include the results of the hardware scan.
    inputs.nur.nixosModules.nur
    inputs.home-manager.nixosModules.home-manager
    inputs.nix-flatpak.nixosModules.nix-flatpak
   ];
  networking.hostName = "workboi"; # Define your hostname.

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;
  xdg.portal.enable = true;

  users = {
    users = {
      narlotti = {
        description = "Nikola Arlotti";
        home = "/home/narlotti";
        extraGroups = [ "wheel" "networkmanager" "vboxusers"];
        isNormalUser = true;
      };
      niko = {
        description = "Second Cooler Nikola Arlotti";
        home = "/home/niko";
        extraGroups = [ "wheel" "networkmanager" "vboxusers"];
        isNormalUser = true;
      };
    };
  };

    programs = {
      firefox.enable = true;
      steam.enable = true;
      gamemode.enable = true;
    };
}
