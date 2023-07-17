vim.cmd.packadd 'vim-jetpack'
require('jetpack.packer').startup(function(use)
	use {'tani/vim-jetpack', opt = 1}
  use 'neovim/nvim-lspconfig'
	use 'williamboman/mason.nvim'
	use 'williamboman/mason-lspconfig.nvim'
--	use 'hrsh7th/nvim-cmp'
--	use 'hrsh7th/cmp-nvim-lsp'
--	use 'hrsh7th/vim-vsnip'
	use 'akinsho/toggleterm.nvim'
	use 'folke/tokyonight.nvim'
  use 'nvim-lualine/lualine.nvim'
  use 'NvChad/NvChad'
end)

-- Using lazygit in nvim.
function _lazygit_toggle()
  local Terminal = require("toggleterm.terminal").Terminal
  local lazygit = Terminal:new({
	  cmd = "lazygit",
	  direction = "float",
	  hidden = true
  })
	lazygit:toggle()
end


-- Set colorscheme.
require("tokyonight").setup({
  styles = {
    comments = { italic = false }
  }
})
vim.cmd.colorscheme "tokyonight-night"
require("lualine").setup {
  options = {
    theme = 'tokyonight'
  }
}


-- Setting LSP by Mason.
--require('mason').setup()
--require('mason-lspconfig').setup_handlers({ function(server)
--  local opt = {
--    capabilities = require('cmp_nvim_lsp').default_capabilities(
--      vim.lsp.protocol.make_client_capabilities()
--    )
--  }
--  require('lspconfig')[server].setup(opt)
--  end
--})


-- LSP hundlers
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, { virtual_text = false }
)


-- Setting cmp.
--local cmp = require("cmp")
--cmp.setup({
--  snippet = {
--    expand = function(args)
--      vim.fn["vsnip#anonymous"](args.body)
--    end,
--  },
--  sources = {
--    { name = "nvim_lsp" },
--  },
--  mapping = cmp.mapping.preset.insert({
--    ["<C-p>"] = cmp.mapping.select_prev_item(),
--    ["<C-n>"] = cmp.mapping.select_next_item(),
--    ['<C-l>'] = cmp.mapping.complete(),
--    ['<C-e>'] = cmp.mapping.abort(),
--   ["<CR>"] = cmp.mapping.confirm { select = true },
--  }),
--  experimental = {
--    ghost_text = true,
--  },
--})

