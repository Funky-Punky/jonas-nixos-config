{
  inputs,
  pkgs,
  ...
}:
{

  #programs.hyprland = {
  #  enable = true;
  #  package = inputs.hyprland.packages."${pkgs.system}".hyprland;
  #  xwayland.enable = true;
  #};

  # environment.sessionVariables = {
    # Forces Qt apps to use Wayland, falling back to X11 (xcb) if necessary
    # QT_QPA_PLATFORM = "xcb";
    # Ensures apps recognize the Wayland session
    # XDG_SESSION_TYPE = "wayland";
    # Common hint for Electron and other toolkit-based apps
    # NIXOS_OZONE_WL = "1";
  # };

  environment.systemPackages = [
    (pkgs.symlinkJoin {
      name = "qgis-wrapped";
      paths = [ pkgs.qgis ];
      buildInputs = [ pkgs.makeWrapper ];
      postBuild = ''
        wrapProgram $out/bin/qgis \
          --set QT_QPA_PLATFORM xcb
      '';
    })
  ];

  # environment.variables = {
  #   QT_QPA_PLATFORM = "wayland;xcb";
  # };

  # environment.systemPackages = [
  #   (pkgs.qgis.overrideAttrs (old: {
  #     postInstall = (old.postInstall or "") + ''
  #       wrapProgram $out/bin/qgis \
  #         --set QT_QPA_PLATFORM xcb
  #     '';
  #   }))
  # ];

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