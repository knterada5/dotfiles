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

-- Install packages at first activation.
local HOME = vim.api.nvim_exec([[echo $HOME]], true)
if io.open(HOME.."/.config/nvim/activated") then
  io.close()
else
  vim.cmd 'JetpackSync'
  vim.cmd 'q'
  vim.api.nvim_exec("!touch "..HOME.."/.config/nvim/activated", true)
end

vim.cmd('q')
