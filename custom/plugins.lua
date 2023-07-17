local plugins = {
  {"williamboman/mason.nvim"},

  {
    "neovim/nvim-lspconfig",
    config = function ()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },

  {"akinsho/toggleterm.nvim"},

  {"williamboman/mason-lspconfig.nvim"},
}

return plugins
