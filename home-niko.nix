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

    # programming
    vscode
  ];

  home.stateVersion = "24.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
