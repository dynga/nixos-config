{ config, pkgs, inputs,  ... }:

{

 imports =
   [ 
    inputs.home-manager.nixosModules.home-manager
    ./hardware-configuration.nix
   ];

  networking.hostName = "evergiven";

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 22 80 443 25565 25575 ];
    allowedUDPPorts = [ 25565 ];
  };
  
  services.fail2ban = {
    enable = true;
   # Ban IP after 5 failures
    maxretry = 5;
    ignoreIP = [
      # Whitelist some subnets
      "10.0.0.0/8" "172.16.0.0/12" "192.168.0.0/16"
      "8.8.8.8" # whitelist a specific IP
      "nixos.wiki" # resolve the IP via DNS
    ];
    bantime = "24h"; # Ban IPs for one day on the first ban
    bantime-increment = {
      enable = true; # Enable increment of bantime after each violation
#      formula = "ban.Time * math.exp(float(ban.Count+1)*banFactor)/math.exp(1*banFactor)";
      multipliers = "1 2 4 8 16 32 64";
      maxtime = "168h"; # Do not ban for more than 1 week
      overalljails = true; # Calculate the bantime based on all the violations
    };
   };

  boot.loader.grub = {
    enable = true;
    device = "/dev/vda";
  };

  users = {
    users = {
      suez = {
        description = "The Suez Canal";
        home = "/home/suez";
        extraGroups = [ "wheel" "networkmanager" "vboxusers" "docker"];
        isNormalUser = true;
      };
    };
  };

  programs = {
    bash = {
      interactiveShellInit = ''
        if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
        then
          shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
          exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
        fi
        '';
    };
  };

}
