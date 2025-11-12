{ inputs, config, pkgs, pkgs-unstable, ... }:

{

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "bckp";
    users = {
      niko = {
        home.username = "niko";
        home.homeDirectory = "/home/niko";

        home.packages = 
        
        (with pkgs; [

          # graphical programs

          spotify
          obsidian
          legcord
          signal-desktop
          element-desktop
          prismlauncher
          vivaldi
          obs-studio
          vlc

          # creative

          # davinci-resolve
          android-studio
          vscode
          libreoffice

          # utilities

          transmission_4-qt
          # ventoy-full
          gparted
          lutris
          filezilla
          logiops
          signal-export

          # Gnome/KDE

          gnome-disk-utility

          kdePackages.filelight
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
        ]

        ++

        (with pkgs-unstable; [
          gimp3
        ])
        );

        home.stateVersion = "25.05";

        dconf.enable = true;
        dconf.settings = {
          "org/gnome/deja-dup" = {
            delete-after = 30;
          };
        };

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

        xdg.configFile."openxr/1/active_runtime.json".source = "${pkgs.monado}/share/openxr/1/openxr_monado.json";
        
        programs.home-manager.enable = true;
        
      };
      };
    };
}
