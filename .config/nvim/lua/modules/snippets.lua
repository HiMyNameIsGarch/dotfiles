local ls = require "luasnip"
-- local types = require "luasnip.util.types"

ls.config.set_config {
    history = true,
    updateenvent = "TextChanged,TextChangedI",
    enable_autosnippets = true,
    ext_opts = nil
}

-- Keymaps
-- This will expand the current item or jump to the next item within the snippet
vim.keymap.set({'i', 's'}, '<c-k>', function ()
    if ls.expand_or_jumpable() then
        ls.expand_or_jump()
    end
end, { silent = true })

-- This will move to the previous item within the snippet
vim.keymap.set({'i', 's'}, '<c-j>', function ()
    if ls.jumpable(-1) then
        ls.jump(-1)
    end
end, { silent = true })

-- Selecting within list of options, usefull for choice nodes
vim.keymap.set('i', '<c-l>', function ()
    if ls.choice_active() then
        ls.change_choice(1)
    end
end, { silent = true })

ls.add_snippets(nil, {
    -- all = {
    -- },
    lua = {
        ls.parser.parse_snippet("lf", "local $1 = function($2)\n\t$0\nend")
    }
})
-- keymaps
vim.keymap.set('n', '<leader><leader>s', "<cmd>source ~/.config/nvim/lua/modules/snippets.lua<CR>")
