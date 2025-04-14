{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=v0.4.1";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disk = { 
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.92.0.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser.url = "github:oscilococcinum/zen-browser-nix";
  };

  outputs = inputs@{ 
    nixpkgs,
    nixpkgs-unstable, 
    nix-flatpak, 
    home-manager, 
    disko, 
    lix-module,
    ... }: 

  let 
    defaultConfig = {
      nix.settings = {
        experimental-features = ["nix-command" "flakes"];
        trusted-users = ["root" "@wheel"];
      };
    };
    lix = lix-module.nixosModules.default;
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
        defaultConfig
        mainModule
        lix
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
        evergiven = mkSystem ./hosts/evergiven {
          modules = [
            ./config-general.nix
            ./modules/containers.nix
            # grub on mbr needs to be configured on a case-by-case basis
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
