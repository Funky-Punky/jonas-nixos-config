{
  inputs,
  pkgs,
  ...
}:
{
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  
    # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    xournalpp
    brightnessctl
    light
    cava
    libreoffice-qt6-fresh
    playerctl
    pavucontrol
    wget
    neofetch
    alacritty
    rofi
    kdePackages.dolphin
    helvum
    pulseaudio
    discord
    helix
    qimgv
    rustc
    busybox
  ];
  programs.firefox.enable = true;

  #programs.hyprland = {
  #  enable = true;
  #  package = inputs.hyprland.packages."${pkgs.system}".hyprland;
  #  xwayland.enable = true;
  #};  
  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages."${pkgs.system}".hyprland;
    xwayland.enable = true;
  };

  services.greetd = {
    enable = true;
    settings = rec {
      initial_session = {
        command = "Hyprland";
        user = "jonas";
      };
      default_session = initial_session;
    };
  };

  # fonts:
  fonts.packages = with pkgs; [ nerd-fonts.hack nerd-fonts.lekton ];

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

    # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  services.devmon.enable = true;
  services.gvfs.enable = true; 
  services.udisks2.enable = true;
  security.polkit.enable = true;
}