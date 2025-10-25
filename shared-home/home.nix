{
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    ./nvf.nix
  ];


  programs.bash = {
    enable = true;
    shellAliases = {
      btw = "echo I use NixOs btw";
    };
    sessionVariables = {
      EDITOR = "vim";
    };
  };

  programs.kitty = {
    enable = true;
    settings = {
      #background_opacity = 0.8;
    };
  };

  programs.ranger = {
    enable = true;
    settings = {
      show_hidden = true;
    };
  };

  programs.vscode = {
  enable = true;
  extensions = with pkgs.vscode-extensions; [
    jnoortheen.nix-ide
  ];
};

  programs.git.enable = true;
  programs.git.userName = "Honas";
  programs.git.userEmail = "jonas.reinstaedtler@web.de";


}