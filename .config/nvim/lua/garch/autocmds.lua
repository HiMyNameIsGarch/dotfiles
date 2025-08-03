local M = {}

function M.setup()
  -- Create augroup to prevent duplicate autocommands on reload
  local augroup = vim.api.nvim_create_augroup("MyAutoCmds", { clear = true })

    -- Formatting
    vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        pattern = { "*.ts", "*.js", "*.vue", "*.tsx" },
        command = "Neoformat"
    })
    vim.g.neoformat_try_node_exe = 1

    vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
        group = augroup,
        pattern = { "*.ejs" },
        command = "set filetype=html"
    })

    vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        pattern = "*",
        command = ':%s/\\s\\+$//e'
    })

    vim.api.nvim_create_autocmd("BufWritePost", {
        group = augroup,
        pattern = "*.tex",
        command = "silent !latex_prev ./%"
    })
end

return M

