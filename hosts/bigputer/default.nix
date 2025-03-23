# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
 imports =
   [
    inputs.home-manager.nixosModules.home-manager
    inputs.nix-flatpak.nixosModules.nix-flatpak
    ./hardware-configuration.nix
   ];

  networking.hostName = "bigputer";
  xdg.portal.enable = true;

  users = {
    users = {
      niko = {
        description = "Nikola Arlotti";
        home = "/home/niko";
        extraGroups = [ "wheel" "networkmanager" "vboxusers"];
        isNormalUser = true;
      };
    };
  };

  environment.systemPackages = 
  
    (with pkgs; [
      waydroid
      waypipe
      wineWowPackages.stable
      protonup-qt
      winetricks
      protontricks
      flatpak-builder
      spice-gtk
    ])

    ++

    (with pkgs-unstable; [
      deja-dup
    ]);

  programs = {
    firefox.enable = true;
    steam = {
      enable = true;
      extraCompatPackages = with pkgs; [
        proton-ge-bin
      ];
    };
    gamemode.enable = true;

    fish.enable = true;

    bash = {
      interactiveShellInit = ''
        if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
        then
          shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
          exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
        fi
        '';
    };
  };

    virtualisation = {
      podman = {
        enable = true;
      };
    };
}
