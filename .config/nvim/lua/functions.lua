function GetNextStr(length)
  local pos = length - 1
  local str = vim.api.nvim_exec("echo getline('.')[col('.')-1:col('.')-1+"..pos.."]", true)
  return str
end


-- Open terminal window and activate python venv.
function OpenTerminalPy()
  if TERM_WIN_ID == 0 then
    vim.cmd('botright 5split term://$SHELL')
    if PROJEXIST then
      vim.cmd('startinsert')
      os.execute("sleep 0.5")
      vim.cmd('call feedkeys("source .venv/bin/activate\\<CR>")')
    else
      vim.cmd('startinsert')
      os.execute("sleep 0.5")
      vim.cmd('call feedkeys("source ~/.config/nvim/.venv/bin/activate\\<CR>")')
    end
    TERM_WIN_ID = vim.api.nvim_exec("echo win_getid()", true) 
  else
    vim.cmd('call win_gotoid('..TERM_WIN_ID..')')
    vim.cmd('startinsert')
  end
end
