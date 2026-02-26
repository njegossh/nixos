{ ... } : {
  programs.nvf = {
    enable = true;
    settings.vim = {
      maps.normal = {
        "<Tab>" = { action = ":bnext<CR>"; desc = "Next buffer"; };
        "<S-Tab>" = { action = ":bprev<CR>"; desc = "Previous buffer"; };
        "f" = { action = ":lua require('fzf-lua').files()<CR>"; desc = "FZF"; };
      };
      undoFile.enable = true;
      autocomplete.nvim-cmp.enable = true;
      clipboard = {
        enable = true;
        providers.wl-copy.enable = true;
        registers = "unnamedplus";
      };
      options = {
        tabstop = 2;
        shiftwidth = 2;
        laststatus = 0;
        number = false;
        relativenumber = false;
        signcolumn = "auto";
      };
      theme = {
        transparent = true;
        enable = true;
        name = "gruvbox";
        style = "dark";
      };
      languages = {
        enableTreesitter = true;
        clang.enable = true;
        csharp.lsp.enable = true;
        csharp.enable = true;
        python.enable = true;
        dart.enable = true;
        nix.enable = true;
      };
      lsp = {
        enable = true;
        #formatOnSave = true;
        mappings = {
          hover = "K";
          codeAction = "L";
          goToDefinition = "gd";
          renameSymbol = "<leader>rn";
        };
      };
      fzf-lua.enable = true;
      filetree.nvimTree = {
        enable = true;
        openOnSetup = false;
        mappings.toggle = "<C-b>";
      };
    };
  };
}
