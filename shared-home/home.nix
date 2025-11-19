{
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    ./nvf.nix
  ];

  home.packages = with pkgs; [
    devenv
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

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = "firefox.desktop";
      "x-scheme-handler/http" = "firefox.desktop";
      "x-scheme-handler/https" = "firefox.desktop";
      "x-scheme-handler/about" = "firefox.desktop";
      "x-scheme-handler/unknown" = "firefox.desktop";
    };
  };

  # https://unix.stackexchange.com/questions/379632/how-to-set-the-default-browser-in-nixos

  programs.git.enable = true;
  programs.git.userName = "Honas";
  programs.git.userEmail = "jonas.reinstaedtler@web.de";


}