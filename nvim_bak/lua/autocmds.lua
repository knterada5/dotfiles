--vim.api.nvim_create_autocmd("WinEnter", {
--    pattern = {"*"},
--    callback = function()
--      local bufName = vim.cmd("echo expand('%:p')[0:3]")
--    end
--    })

