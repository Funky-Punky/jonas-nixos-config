{
  config,
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    inputs.nvf.homeManagerModules.default
    inputs.spicetify-nix.homeManagerModules.default
  ];

  home.username = "jonas";
  home.homeDirectory = "/home/jonas";
  home.stateVersion = "25.05";

  programs.bash = {
    enable = true;
    shellAliases = {
      btw = "echo I use NixOs btw";
      nrs = "sudo nixos-rebuild switch --flake /home/jonas/jonas-nixos-config/nixos --impure";
    };
    sessionVariables = {
      EDITOR = "vim";
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
      #vim.visuals.nvim-cursorline.enable = true;
      #options.cursorlineopt = "both";

      vim.diagnostics.enable = true;
      vim.diagnostics.config.virtual_text = true;

      vim.theme = {
        enable = true;
        name = "onedark";
        style = "deep";
      };

      vim.statusline.lualine.enable = true;
      vim.statusline.lualine.theme = "onedark";
      vim.autocomplete.nvim-cmp.enable = true;

      vim.lsp = {
        enable = true;
        lspkind.enable = true;
        lspsaga.enable = true;
        otter-nvim.enable = true;
      };

      vim.languages = {
        enableTreesitter = true;

        nix.enable = true;
        markdown.enable = true;
        rust.enable = true;
        rust.crates.enable = true;
      };

      vim.spellcheck = {
        enable = true;
        programmingWordlist.enable = true;
      };

      vim.keymaps = [
        {
          key = "<leader>ca";
          mode = "n";
          action = "<cmd>Lspsaga code_action<CR>";
          desc = "Show Code Actions";
        }
        {
          key = "<leader>d";
          mode = "n";
          action = "<cmd>lua vim.diagnostic.config({ virtual_text = not vim.diagnostic.config().virtual_text })<CR>";
          desc = "Toggle Inline code errors";
        }
      ];
    };
  };


  programs.spicetify =
    let
      spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
    in
    {
      enable = true;
      enabledExtensions = with spicePkgs.extensions; [
        adblock
      ];
    };

}
