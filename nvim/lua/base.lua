-- Set current python path
if vim.g.python3_host_prog == nil then
  vim.g.python3_host_prog = "~/.config/nvim/.venv/bin/python3"
  PROJEXIST = false
end

TERM_WIN_ID = 0

-- Move to buffer directory.
local bufname = vim.api.nvim_exec('echo bufname("%")', true)
if bufname ~= "" then
  vim.cmd('cd %:h')
else
  NONAME = true
end

-- Move to root directory, which has .git etc..
local cmd = io.popen('echo -n $(bash ~/.config/nvim/scripts/find_root.sh)')
local root = cmd:read("*all")
cmd:close()
if root == "" then
  PROJEXIST = false
else
  -- If root exists, setting virtual env and path.
  PROJEXIST = true
  vim.env.VIRTUAL_ENV = root..'/.venv'
  vim.env.PATH = root..'/.venv/bin:'..vim.env.PATH
  vim.cmd('cd '..root)
end

