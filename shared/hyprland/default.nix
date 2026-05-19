{
  inputs,
  pkgs,
  ...
}:
{

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
    fragment-mono
  ];

  environment.systemPackages = with pkgs; [
    (symlinkJoin {
      name = "qgis-wrapped";
      paths = [ qgis ];
      buildInputs = [ makeWrapper ];
      postBuild = ''
        wrapProgram $out/bin/qgis \
          --set QT_QPA_PLATFORM xcb
      '';
    })
    nwg-displays
    signal-desktop
    mendeley
    hyprshot
    thunderbird
    xournalpp
    cava
    libreoffice-qt6-fresh
    kdePackages.filelight
    gparted
    playerctl
    teams-for-linux
    pavucontrol
    chromium
    vlc
    alacritty
    rofi
    kdePackages.dolphin
    helvum
    discord
    jetbrains.pycharm
    jetbrains.datagrip
    qimgv
    hyprpolkitagent
    graphviz
    gv
  ];

  programs.firefox.enable = true;

  nix.settings = {
    substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };

  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;

  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages."${pkgs.system}".hyprland;
    xwayland.enable = true;
    withUWSM = true;
  };

  systemd.services.display-manager.path = [ pkgs.uwsm ];
  security.pam.services.hyprlock = {};
  security.polkit.enable = true;

}