{ inputs, config, pkgs, ... }:

{
  # imports = [ ./flake.nix flake-inputs.nix-flatpak.homeManagerModules.nix-flatpak ];

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "niko";
  home.homeDirectory = "/home/niko";

  home.packages = with pkgs; [

    # graphical programs

    firefox
    spotify
    obsidian
    vesktop
    prismlauncher
    vivaldi

    android-studio
    vscode

    transmission-qt
    gparted
    lutris
    libreoffice
    deja-dup
    vlc

    gnome.gnome-disk-utility
    kdePackages.filelight
    kdePackages.kdeconnect-kde

    #cli utilities

    distrobox
  ];

  programs = {
    firefox = {
      enable = true;
      profiles = {
        private = {
          name = "Private";
          id = 1;
          isDefault = true;
          search.default = "DuckDuckGo";
          settings = {
            "extensions.autoDisableScopes" = 0;
          };
          extensions = with inputs.firefox-addons.packages.${pkgs.system}; [
            adnauseam
            bitwarden
            consent-o-matic
            # enhancer-for-youtube
            decentraleyes
            playback-speed
          ];
        };
      };
      
    };
    fzf.enable = true;

    fish = {
      enable = true;
    };
  };

  nixpkgs.config.allowUnfree = true;

  services.flatpak.packages = [
    "org.signal.Signal"
  ];

  home.stateVersion = "24.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
