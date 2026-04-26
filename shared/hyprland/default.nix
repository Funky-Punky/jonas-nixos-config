{
  inputs,
  pkgs,
  ...
}:
{

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
    signal-desktop
    mendeley
    hyprshot
    thunderbird
    xournalpp
    cava
    libreoffice-qt6-fresh
    playerctl
    pavucontrol
    chromium
    vlc
    alacritty
    rofi
    kdePackages.dolphin
    helvum
    discord
    jetbrains.pycharm
    qimgv
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

}