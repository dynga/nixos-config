{ inputs, config, pkgs, nur, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "narlotti";
  home.homeDirectory = "/home/narlotti";

  home.packages = with pkgs; [

    # general programs
    firefox
    obsidian
    signal-desktop
    vlc
    vivaldi
    slack

    # programming
    jetbrains.idea-community
    vscode
    deja-dup
    distrobox
  ];

  programs = {
    firefox = {
      enable = true;
      # profiles = {
      #   private = {
      #     name = "Private";
      #     id = 1;
      #     isDefault = false;
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
      #   redhat = {
      #     name = "Red Hat";
      #     id = 2;
      #     isDefault = true;
      #     search.default = "DuckDuckGo";
      #     settings = {
      #       "extensions.autoDisableScopes" = 0;
      #     };
      #     extensions = with pkgs.nur.repos.rycee.firefox-addons; [
      #       adnauseam
      #       bitwarden
      #       consent-o-matic
      #       enchancer-for-youtube
      #       decentraleyes
      #       playback-speed
      #     ];
      #   };
      # };
    };
    fzf.enable = true;
    nix-index = {
        enable = true;
        enableFishIntegration = true;
      };
  };

  home.stateVersion = "24.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
