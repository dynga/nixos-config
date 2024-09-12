{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=v0.4.1";
    nur.url = "github:nix-community/NUR";
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ nixpkgs, nur, firefox-addons, nix-flatpak, home-manager, disko, ... }: {
    nixosConfigurations = {
      bigputer = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./config-general.nix
          ./config-bigputer.nix
          nur.nixosModules.nur
          home-manager.nixosModules.home-manager
          nix-flatpak.nixosModules.nix-flatpak
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = { inherit inputs; };
              users = {
                niko.imports = [ 
                  ./home-niko.nix 
                  nix-flatpak.homeManagerModules.nix-flatpak
                ];
              };
            };
          }
#           disko.nixosModules.disko
#           ./disk-config.nix
        ];
      };
      workboi = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./config-general.nix
          ./config-workboi.nix
          nur.nixosModules.nur
          home-manager.nixosModules.home-manager
          nix-flatpak.nixosModules.nix-flatpak
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs.flake-inputs = inputs;
              users = {
                niko.imports = [ 
                  ./home-niko.nix 
                  nix-flatpak.homeManagerModules.nix-flatpak
                ];
                narlotti.imports = [
                  ./home-narlotti.nix
                  nix-flatpak.homeManagerModules.nix-flatpak
                ];
              };
            };
          }
#           disko.nixosModules.disko
#           ./disk-config.nix
        ];
      };
    };
  };
}
