{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = { 
      device = "/dev/disk/by-uuid/131a5170-5a1a-4921-92aa-fc887bb20d3c";
      fsType = "btrfs";
    };

  fileSystems."/boot" = { 
    device = "/dev/disk/by-uuid/4EB3-D6A5";
    fsType = "vfat";
    options = [ 
      "fmask=0077" 
      "dmask=0077" 
    ];
  };

  swapDevices = [ 
    { device = "/dev/disk/by-uuid/7859ae25-c0f8-4b4a-91e7-8e0284d3ea4c"; } 
    ];

  # data_big
  fileSystems."/mnt/56807f9f-27d7-4cf0-8170-c980da6254ec" = {
    device = "/dev/disk/by-uuid/56807f9f-27d7-4cf0-8170-c980da6254ec";
    fsType = "btrfs";
    options = [
      "defaults"
      "x-gfvs-show"
    ];
  };

  # data_slow
  fileSystems."/mnt/9c537326-ed83-4abd-a25d-d080d91c1c8c" = {
    device = "/dev/disk/by-uuid/9c537326-ed83-4abd-a25d-d080d91c1c8c";
    fsType = "ext4";
    options = [
      "defaults"
      "x-gfvs-show"
    ];
  };

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp4s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.tailscale0.useDHCP = lib.mkDefault true;
  # networking.interfaces.vboxnet0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
