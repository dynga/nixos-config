{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/24.05";
    home-manager.url = "github:nix-community/home-manager";
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
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users = {
                niko = {
                  name = "Nikola Arlotti";
                  home = /home/niko;
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
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users = {
                niko = #{
#                   name = "Second Cooler Nikola Arlotti";
#                   home = /home/niko;
#                   imports = [ ./home-niko.nix ];
                    import ./home-niko.nix;
                  #};
                narlotti = #{
#                   name = "Nikola Arlotti";
#                   home = /home/narlotti;
#                   imports = [ ./home-narlotti.nix ];
                    import ./home-niko.nix;
                  #};
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
