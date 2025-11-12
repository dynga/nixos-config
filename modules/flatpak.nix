{ config, pkgs, ... }:

{
  services.flatpak.enable = true;

  # services.flatpak.update.auto = {
  #   enable = true;
  #   onCalendar = "weekly";
  # };

}