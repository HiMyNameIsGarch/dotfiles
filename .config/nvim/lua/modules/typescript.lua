-- this autocmd uses npm scripts with vitest

local function find_text_line(bufnr, text)
    local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    for i, line in ipairs(lines) do
        if line:find(text) then
            return i - 1
        end
    end
    return nil
end

local ns = vim.api.nvim_create_namespace "live-tests"

local function process_output(bufnr)
    local test_res = io.open(vim.fn.getcwd() .. "/vitest-res.json", 'r');
    if test_res == nil then
        print("file: " .. fname .. " is nil")
        return
    end
    local content = test_res:read('a*');
    local decoded = vim.json.decode(content)
    test_res:close()
    local failed = {}
    local text = { "✓" }
    for _,v in pairs(decoded.testResults[1].assertionResults) do
        if v == nil then
            goto continue
        end
        local line = find_text_line(bufnr, v.title)
        if v.status == 'failed' then
            table.insert(failed, {
                bufnr = bufnr,
                lnum = line,
                col = 0,
                severity = vim.diagnostic.severity.ERROR,
                source = "vitest",
                message = v.failureMessages[1],
                user_data = {},
            })
        else
            vim.api.nvim_buf_set_extmark(bufnr, ns, line, 0, {
                virt_text = { text },
            })
        end
        ::continue::
    end
    vim.diagnostic.set(ns, bufnr, failed, {})
end

vim.api.nvim_create_autocmd("BufWritePost", {
    group = vim.api.nvim_create_augroup("vitest_like_a_pro", {clear = true}),
    pattern = "*.spec.ts",
    callback = function()
        local bufnr = vim.api.nvim_get_current_buf()
        -- clear
        vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)
        vim.diagnostic.reset(ns, bufnr)
        -- start
        local fname = vim.fn.expand("%:t"):gsub(".spec.ts", '');
        vim.fn.jobstart({"npm", "run", "test:json-file", fname}, {
            on_exit = function()
                process_output(bufnr)
            end
        });
    end
})
