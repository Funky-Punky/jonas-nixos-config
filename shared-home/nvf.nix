{
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    inputs.nvf.homeManagerModules.default
  ];

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

      #vim.theme = {
      #  enable = true;
      #  name = "onedark";
      #  style = "deep";
      #  transparent = true;
      #};

      vim.statusline.lualine.enable = true;
      #vim.statusline.lualine.theme = "onedark";
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
}