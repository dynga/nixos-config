{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
#     nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=v0.4.1";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disk = { 
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser.url = "github:oscilococcinum/zen-browser-nix";
  };

  outputs = inputs@{ 
    nixpkgs,
    nixpkgs-unstable, 
    # nix-flatpak, 
    home-manager, 
    disko,
    ... }: 

  let 
    mkSystem = mainModule: {
      modules ? [],
      authorizedKeys ? {},
      system ? "x86_64-linux"
    }: nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { 
        inherit inputs;
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
        pkgs-unstable = import nixpkgs-unstable {
          inherit system;
          config.allowUnfree = true;
        };
      };
      modules = modules ++ [
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
            # ./modules/vr.nix
            ./home/user-niko.nix
          ];
        };
        evergiven = mkSystem ./hosts/evergiven {
          modules = [
            ./config-general.nix
            ./modules/containers.nix
            ./modules/grub-uefi.nix
          ];
        };
        schenker = mkSystem ./hosts/schenker {
          modules = [
            ./config-general.nix
            ./modules/containers.nix
            ./modules/grub-uefi.nix
          ];
        };
      };
    };
  }
