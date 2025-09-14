{
  config,
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    inputs.nvf.homeManagerModules.default
  ];

  home.username = "jonas";
  home.homeDirectory = "/home/jonas";
  home.stateVersion = "25.05";

  programs.bash = {
    enable = true;
    shellAliases = {
      btw = "echo I use NixOs btw";
      nrs = "sudo nixos-rebuild switch -I nixos-config=/home/jonas/jonas-nixos-config/nixos/configuration.nix";
    };
  };

  programs.ranger = {
    enable = true;
    settings = {
      show_hidden = true;
    };
  };

  programs.git.enable = true;
  programs.git.userName = "Honas";
  programs.git.userEmail = "jonas.reinstaedtler@web.de";

  programs.nvf = {
    enable = true;
    settings = {

      vim.viAlias = false;
      vim.vimAlias = true;

      vim.options.shiftwidth = 2;
      # visuals.nvim-cursorline.enable = true;
      # options.cursorlineopt = "both";

      vim.diagnostics.config.virtual_text = true;
      vim.diagnostics.config.virtual_lines = true;

      vim.theme = {
        enable = true;
        name = "gruvbox";
        style = "dark";
      };

      vim.statusline.lualine.enable = true;
      vim.autocomplete.nvim-cmp.enable = true;

      vim.lsp = {
        enable = true;
        lspkind.enable = true;
        lspsaga.enable = true;
        trouble.enable = true;
        otter-nvim.enable = true;
      };

      vim.languages = {
        enableTreesitter = true;

        nix.enable = true;
        rust.enable = true;
        rust.crates.enable = true;
      };

      vim.spellcheck = {
        enable = true;
        programmingWordlist.enable = true;
      };

    };
  };

}
