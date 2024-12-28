{ inputs, config, pkgs, pkgs-unstable, ... }:

{

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users = {
      niko = {
        home.username = "niko";
        home.homeDirectory = "/home/niko";

        home.packages = with pkgs-unstable; [

          # graphical programs

          spotify
          obsidian
          legcord
          prismlauncher
          vivaldi
          obs-studio
#          signal-desktop

          android-studio
          vscode

          transmission_4-qt
          ventoy-full
          gparted
          lutris
          libreoffice
          deja-dup
          vlc
          filezilla

          gnome-disk-utility
          kdePackages.filelight
          kdePackages.kdeconnect-kde
          kdePackages.kolourpaint
          kdePackages.kfind

          #cli utilities

          distrobox
        ];


        home.stateVersion = "24.11";

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

  services.flatpak.packages = [
    "org.signal.Signal"
  ];
}
