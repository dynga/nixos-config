{ config, pkgs, ... }:

{
  programs.virt-manager.enable = true;

  virtualisation = {
    libvirtd.enable = true;
    spiceUSBRedirection.enable = true;
    virtualbox.host.enable = true;
    containers.enable = true;
  };
}
