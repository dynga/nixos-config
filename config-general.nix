# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
 imports =
   [ # Include the results of the hardware scan.
     ./hardware-configuration.nix
     ./modules/containers.nix
   ];


  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    device = "nodev";
    useOSProber = true;
    timeoutStyle = "hidden";
    extraEntries = ''
      menuentry "Reboot" {
        reboot
      }
      menuentry "Poweroff" {
        halt
      }
    '';
  };

  boot.supportedFilesystems = ["nfts"];

  # Enable networking
  networking.networkmanager.enable = true;
  networking.firewall.enable  = false;
  services.tailscale.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Prague";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "cs_CZ.UTF-8";
    LC_IDENTIFICATION = "cs_CZ.UTF-8";
    LC_MEASUREMENT = "cs_CZ.UTF-8";
    LC_MONETARY = "cs_CZ.UTF-8";
    LC_NAME = "cs_CZ.UTF-8";
    LC_NUMERIC = "cs_CZ.UTF-8";
    LC_PAPER = "cs_CZ.UTF-8";
    LC_TELEPHONE = "cs_CZ.UTF-8";
    LC_TIME = "cs_CZ.UTF-8";
  };

  # Configure keymap in X11
  services.xserver = {
    xkb.layout = "us";
    xkb.variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  hardware.bluetooth.enable = true;
  services.ddccontrol.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnfreePredicate = (pkg: true);

  nix.settings.experimental-features = ["nix-command" "flakes"];

  security.polkit.enable = true;

  services.gvfs.enable = true;

  xdg.portal.enable = true;
  services.flatpak.enable = true;
  environment = {
    systemPackages = with pkgs; [
      git
      gh
      vim
      nano
      wget
      curl
      thefuck
      fishPlugins.done
      fishPlugins.fzf-fish
      fishPlugins.forgit
      cifs-utils
      samba
      rar
      htop
      waypipe
      wineWowPackages.stable
      protonup-qt
      winetricks
      protontricks
      flatpak-builder
      nix-output-monitor
      aria2
      lima
      quickemu
      quickgui
      spice-gtk
      mediainfo
      xsettingsd
      xorg.xrdb
      ntfs3g
      inetutils
      trayscale
    ];

    shellAliases = {
      nixos-switch = "NIXPKGS_ALLOW_UNFREE=1 sudo nixos-rebuild switch --impure &| nom";
      nixos-update = "NIXPKGS_ALLOW_UNFREE=1 sudo bash -lic 'cd /etc/nixos && sudo nix flake update && sudo nixos-rebuild switch --impure |& nom'";
    };
  };

  home-manager.backupFileExtension = "backup";


  system.stateVersion = "24.05";

}
