vim.cmd.packadd 'vim-jetpack'
require('jetpack.packer').startup(function(use)
        use {'tani/vim-jetpack', opt = 1}
  use 'neovim/nvim-lspconfig'
        use 'williamboman/mason.nvim'
        use 'williamboman/mason-lspconfig.nvim'
        use 'hrsh7th/nvim-cmp'
        use 'hrsh7th/cmp-nvim-lsp'
        use 'hrsh7th/vim-vsnip'
        use 'akinsho/toggleterm.nvim'
        use 'folke/tokyonight.nvim'
  use 'nvim-lualine/lualine.nvim'
end)

vim.cmd 'JetpackSync'
vim.cmd 'q'
vim.cmd('q')
