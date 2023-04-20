-- Install packages at first activation.
local HOME = vim.api.nvim_exec([[echo $HOME]], true)
if io.open(HOME.."/.config/nvim/activated") then
  io.close()
else
  vim.cmd 'JetpackSync'
  vim.cmd 'q'
  vim.api.nvim_exec("!touch "..HOME.."/.config/nvim/activated", true)
end

require("base")
require("options")
require("plugins")
require("keymaps")
require("autocmds")
require("functions")
