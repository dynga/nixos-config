# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
 imports =
   [ # Include the results of the hardware scan.
    inputs.nur.nixosModules.nur
    inputs.home-manager.nixosModules.home-manager
    inputs.nix-flatpak.nixosModules.nix-flatpak
   ];

  networking.hostName = "bigputer"; # Define your hostname.
  xdg.portal.enable = true;

  # nur.nixosModules.nur
  # home-manager.nixosModules.home-manager
  # nix-flatpak.nixosModules.nix-flatpak
  # home-manager = {
  #   useGlobalPkgs = true;
  #   useUserPackages = true;
  #   users = {
  #     niko.imports = [ 
  #       ./users/home-niko.nix 
  #       nix-flatpak.homeManagerModules.nix-flatpak
  #     ];
  #   };
  # };



  users = {
    users = {
      niko = {
        description = "Nikola Arlotti";
        home = "/home/niko";
        extraGroups = [ "wheel" "networkmanager" "vboxusers"];
        isNormalUser = true;

        packages = with pkgs; [
          davinci-resolve
          logiops
        ];
      };
    };
  };

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


}
