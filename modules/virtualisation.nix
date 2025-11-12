{ config, pkgs, ... }:

{
  programs.virt-manager.enable = true;

  virtualisation = {
    libvirtd = { 
      enable = true;
      qemu.vhostUserPackages = with pkgs; [ virtiofsd ];
    };
    spiceUSBRedirection.enable = true;
    containers.enable = true;
  };
  
  networking.firewall.trustedInterfaces = [
    "virbr0"
  ];
}
