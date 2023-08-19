vim.api.nvim_create_autocmd("BufWritePost", {
    group = vim.api.nvim_create_augroup("vitest_like_a_pro", {clear = true}),
    pattern = "*.spec.ts",
    callback = function()
        print("beginning of the end")
    end
})
