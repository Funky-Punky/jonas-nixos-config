# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../shared/configuration.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
# boot.kernelParams = [ "nomodeset" ];

# 1. nomodeset ENTFERNEN (wichtig für Power Management)
  boot.kernelParams = [ 
    "consoleblank=60"       # Schaltet den Monitor-Output nach 60s Idle aus
    "amdgpu.runpm=1"        # Erzwingt aggressives Runtime Power Management für die GPU
    "amdgpu.dc=1"           # Aktiviert Display Core (nötig für tiefere Sleep States)
#    "video=HDMI-A-1:d"      # Optional: Deaktiviert HDMI komplett (falls vorhanden)
#    "video=DP-1:d"          # Optional: Deaktiviert DisplayPort komplett
  ];

  # 2. AMDGPU Treiber früh laden, damit er die Hardware kontrolliert
  boot.initrd.kernelModules = [ "amdgpu" ];
  
  # 3. Firmware für die Vega-Grafik bereitstellen
  hardware.enableRedistributableFirmware = true;

  # 4. Automatisches Stromsparen via Powertop
  powerManagement.powertop.enable = true;

  time.hardwareClockInLocalTime = true;

  networking.hostName = "server-nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  
  virtualisation.docker.daemon.settings.ipv6 = true;
  virtualisation.docker.daemon.settings.ip6tables = true;
  virtualisation.docker.daemon.settings.fixed-cidr-v6 = "fd00::/80";
  

  systemd.network.networks."eno1" = {
    matchConfig.Name = "eno1";

    networkConfig = {
      IPv6AcceptRA = true;
    };

    ipv6AcceptRAConfig = {
      UseStablePrivacyAddress = true;
    };
  };


  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jonas = {
    isNormalUser = true;
    description = "jonas";
    extraGroups = [
      "networkmanager"
      "wheel"
      "audio"
      "docker"
    ];
  };

  nix.settings.trusted-users = [ "root" "jonas" ];

  environment.systemPackages = with pkgs; [
    sysbench
    tcpdump
  ];
  
#  powerManagement.enable = true;
#  powerManagement.powertop.enable = true;
#  powerManagement.cpuFreqGovernor = "powersave";
#  powerManagement.resumeCommands = ''
#    echo "System resumed"
#  '';


  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}
