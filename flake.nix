{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/24.05";
    nur.url = "github:nix-community/NUR";
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ nixpkgs, home-manager, disko, ... }: {
    nixosConfigurations = {
      bigputer = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./config-general.nix
          ./config-bigputer.nix
          nur.nixosModules.nur
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users = {
                niko = {
                  imports = [ ./home-niko.nix ];
                  };
              };
            };
          }
          disko.nixosModules.disko
          ./disk-config.nix
        ];
      };
      workboi = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./config-general.nix
          ./config-workboi.nix
          nur.nixosModules.nur
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users = {
                niko = import ./home-niko.nix;
                narlotti = import ./home-narlotti.nix;
              };
            };
          }
          disko.nixosModules.disko
          ./disk-config.nix
        ];
      };
    };
  };
}
