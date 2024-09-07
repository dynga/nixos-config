{ config, pkgs, ... }:

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

    # programming
    jetbrains.idea-community
    vscode

    distrobox
  ];

  programs = {
    firefox = {
      enable = true;
      profiles = {
        private = {
          name = "Private";
          id = 1;
          isDefualt = false;
          search.default = "DuckDuckGo";
          settings = {
            "extensions.autoDisableScopes" = 0;
          };
          extensions = with pkgs.nur.repos.rycee.firefox-addons; [
            adnauseam
            bitwarden
            consent-o-matic
            enchancer-for-youtube
            decentraleyes
            playback-speed
          ];
        };
        redhat = {
          name = "Red Hat";
          id = 2;
          isDefault = true;
          search.default = "DuckDuckGo";
          settings = {
            "extensions.autoDisableScopes" = 0;
          };
          extensions = with pkgs.nur.repos.rycee.firefox-addons; [
            adnauseam
            bitwarden
            consent-o-matic
            enchancer-for-youtube
            decentraleyes
            playback-speed
          ];
        };
      };
    };
    fzf.enable = true;
  };

  home.stateVersion = "24.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
