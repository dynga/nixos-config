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

  outputs = inputs@{ nixpkgs, nur, firefox-addons, nix-flatpak, home-manager, disko, ... }: 

  let 
    defaultConfig = {
      nix.settings = {
        experimental-features = ["nix-command" "flakes"];
        trusted-users = ["root" "@wheel"];
      };
    };
    mkSystem = mainModule: {
      modules ? [],
      authorizedKeys ? {},
      system ? "x86_64-linux"
    }: nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit inputs; };
      modules = modules ++ [
        defaultConfig
        mainModule
      ];
    };

    in {

      nixosConfigurations = {
        bigputer = mkSystem ./hosts/bigputer {
          modules = [
            ./config-general.nix
            ./modules/grub-uefi.nix
            ./modules/drivers-nvidiagpu.nix
            ./modules/flatpak.nix
            ./modules/kde.nix
            ./modules/virtualisation.nix
            ./home/user-niko.nix
          ];
        };
        workboi = mkSystem ./hosts/workboi {
          modules = [
            ./config-general.nix
            ./modules/flatpak.nix
            ./modules/kde.nix
            ./modules/virtualisation.nix
            ./modules/grub-uefi.nix
            ./home/user-niko.nix
            ./home/user-narlotti.nix
            ];
          };
        evergiven = mkSystem ./hosts/evergiven {
          modules = [
            ./config-general.nix
            ./modules/containers.nix
            # grub on mbr needs to be configured on a case-by-case basis
          ];
        };
      };
    };
  }
