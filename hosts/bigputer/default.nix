# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, pkgs-unstable, inputs, ... }:

{
 imports =
   [
    inputs.home-manager.nixosModules.home-manager
#     inputs.nix-flatpak.nixosModules.nix-flatpak
    ./hardware-configuration.nix
   ];

  networking.hostName = "bigputer";
  xdg.portal.enable = true;

  users = {
    users = {
      niko = {
        description = "Nikola Arlotti";
        home = "/home/niko";
        extraGroups = [ "wheel" "networkmanager" "libvirtd"];
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
      inputs.zen-browser.packages."${system}".default
      nvtopPackages.full
      syncthing


      kdePackages.krfb
      kdePackages.krdc

      android-tools
    ])

    ++

    (with pkgs-unstable; [
      deja-dup
      kdePackages.kdenlive
    ])
    ;

  programs = {
    firefox.enable = true;
    steam = {
      enable = true;
      extraCompatPackages = with pkgs; [
        proton-ge-bin
      ];
    };
    gamemode.enable = true;
    kdeconnect.enable = true;

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



  services = {
    xrdp = {
      defaultWindowManager = "startplasma-x11";
      enable = true;
      openFirewall = true;
    };

    xserver = {
      enable = true;

      xkb = {
        layout = "us";
        variant = "";
      };
    };


  };

    virtualisation = {
      podman = {
        enable = true;
      };
    };
}
