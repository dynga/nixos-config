{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "narlotti";
  home.homeDirectory = "/home/narlotti";

  home.packages = with pkgs; [

    # general programs
    obsidian
    signal-desktop

    # programming
    jetbrains.idea-community
    vscode

    distrobox
  ];

  programs = {
    firefox.enable = true;
    fzf.enable = true;
  };

  home.stateVersion = "24.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
