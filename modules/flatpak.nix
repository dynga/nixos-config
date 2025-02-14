{ config, pkgs, ... }:

{
  services.flatpak.enable = true;

  services.flatpak.packages = [
    "org.signal.Signal"
  ];

  services.flatpak.update.auto = {
    enable = true;
    onCalendar = "weekly";
  };

}