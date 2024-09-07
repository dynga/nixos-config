{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "niko";
  home.homeDirectory = "/home/niko";

  home.packages = with pkgs; [

    # general programs
    spotify
    obsidian
    vesktop
    signal-desktop

    # gaming
    prismlauncher
    lutris

    # programming
    vscode
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
        };;
      };
    };
    fzf.enable = true;
  };

  home.stateVersion = "24.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
