{ inputs, config, pkgs, pkgs-unstable, ... }:

{

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
    users = {
      niko = {
        home.username = "niko";
        home.homeDirectory = "/home/niko";

        home.packages = with pkgs; [

          # graphical programs

          spotify
          obsidian
          legcord
          signal-desktop
          element-desktop
          prismlauncher
          vivaldi
          obs-studio
          gimp
          vlc

          # creative

          davinci-resolve
          android-studio
          vscode
          libreoffice

          # utilities

          transmission_4-qt
          ventoy-full
          gparted
          lutris
          deja-dup
          filezilla
          logiops
          signal-export

          # Gnome/KDE

          gnome-disk-utility

          kdePackages.filelight
          kdePackages.kdeconnect-kde
          kdePackages.kolourpaint
          kdePackages.kfind
          kdePackages.tokodon
          kdePackages.qtmultimedia

          # language servers

          bash-language-server
          python312Packages.python-lsp-server
          jq
          ruff
          python3Full
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
}
