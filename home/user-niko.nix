{ inputs, config, pkgs, ... }:

{
  # imports = [ ./flake.nix flake-inputs.nix-flatpak.homeManagerModules.nix-flatpak ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users = {

#       users = {
            niko = {
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
          obs-studio

          android-studio
          vscode

          transmission-qt
          ventoy-full
          gparted
          lutris
          libreoffice
          deja-dup
          vlc

          gnome.gnome-disk-utility
          kdePackages.filelight
          kdePackages.kdeconnect-kde
          kdePackages.kolourpaint

          #cli utilities

          distrobox
        ];


        home.stateVersion = "24.05";

        programs = {
          firefox = {
            enable = true;
            # profiles = {
            #   private = {
            #     name = "Private";
            #     id = 1;
            #     isDefault = true;
            #     search.default = "DuckDuckGo";
            #     settings = {
            #       "extensions.autoDisableScopes" = 0;
            #     };
            #     extensions = with inputs.firefox-addons.packages.${pkgs.system}; [
            #       adnauseam
            #       bitwarden
            #       consent-o-matic
            #       # enhancer-for-youtube
            #       decentraleyes
            #       playback-speed
            #     ];
            #   };
            # };

          };
          fzf.enable = true;
          fish = {
            enable = true;
          };
        };
        programs.home-manager.enable = true;
      };
      };
    };
#   };



  nixpkgs.config.allowUnfree = true;

  services.flatpak.packages = [
    "org.signal.Signal"
  ];
}
