{ config, pkgs, inputs,  ... }:

{

 imports =
   [ # Include the results of the hardware scan.
    inputs.nur.nixosModules.nur
    inputs.home-manager.nixosModules.home-manager
    inputs.nix-flatpak.nixosModules.nix-flatpak
   ];
  networking.hostName = "evergiven"; # Define your hostname.


    boot.loader.grub = {
        enable = true;
        extraEntries = ''
        menuentry "Reboot" {
            reboot
        }
        menuentry "Poweroff" {
            halt
        }
        '';
    };


  users = {
    users = {
      suez = {
        description = "The Suez Canal";
        home = "/home/suez";
        extraGroups = [ "wheel" "networkmanager" "vboxusers"];
        isNormalUser = true;
      };
    };
  };

}
