{
  pkgs,
  config,
  inputs,
  ...
}: {
  imports = [
    inputs.stylix.homeModules.stylix
  ];
  stylix = {
    enable = true;
    polarity = "dark";
    opacity.terminal = 0.9;
    base16Scheme = {
      #scheme: "Rosé Pine"
      #author: "Emilia Dunfelt <edun@dunfelt.se>"
base00= "24283b";
base01= "1f2335";
base02= "292e42";
base03= "565f89";
base04= "a9b1d6";
base05= "c0caf5";
base06= "c0caf5";
base07= "c0caf5";
base08= "f7768e";
base09= "ff9e64";
base0A= "e0af68";
base0B= "9ece6a";
base0C= "1abc9c";
base0D= "41a6b5";
base0E= "bb9af7";
base0F= "ff007c";
    };
    #icons = {
    #  enable = true;
    #  package = pkgs.mate.mate-icon-theme;
    #};
    cursor = {
      size = 28;
      package = pkgs.openzone-cursors;
      name = "OpenZone_White_Slim";
    };
    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.hack;
        name = "nerd-fonts-hack";
      };
      sansSerif = {
        package = pkgs.nerd-fonts.hack;
        name = "nerd-fonts-hack";
      };
      serif = {
        package = pkgs.nerd-fonts.hack;
        name = "nerd-fonts-hack";
      };
      sizes = {
        applications = 10;
        terminal = 14;
        desktop = 14;
        popups = 12;
      };
    };
  };

  #stylix.image = ./
}
