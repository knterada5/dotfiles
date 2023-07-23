local M = {}
M.key = {
  n = {
    ["lg"] = {"<cmd>lua _lazygit_toggle()<CR>", "lazygit"},
  },
  t = {
    ["<ESC>"] = {"<C-\\><C-n>", "escape terminal"},
  }
}

return M
