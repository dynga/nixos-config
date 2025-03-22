{ config, pkgs, ... }:

{
  programs.virt-manager.enable = true;

  virtualisation = {
    libvirtd.enable = true;
    spiceUSBRedirection.enable = true;
    containers.enable = true;
  };
}
