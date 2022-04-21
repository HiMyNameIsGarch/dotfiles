local ls = require "luasnip"

ls.config.set_config {
    history = true,
    update_events = "TextChanged,TextChangedI",
    enable_autosnippets = true,
    ext_opts = nil
}

-- Keymaps

-- Reload faster
vim.keymap.set('n', '<leader><leader>s', "<cmd>source ~/.config/nvim/lua/modules/snippets.lua<CR>")

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

local del = function(len, verify)
    if len == 0 then return '' end
    local total = (75 - len) / 2
    if len % 2 == 0 and verify then total = total + 1 end
    local block = ''
    for _ = 0, total do block = block .. '-' end
    return block
end

local f = ls.function_node
local s, i = ls.s, ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

local same = function(index)
    return f(function(args)
        return args[1]
    end, { index })
end

ls.add_snippets(nil, {
    all = {
        s("md",
            fmt(
                [[ {}< {} >{} ]],
                { f(function(import_name)
                    local text = import_name[1][1]
                    return del(#text + 1, true)
                end, { 1 }),
                i(1),
                f(function(import_name)
                    local text = import_name[1][1]
                    return del(#text + 1, false)
                end, { 1 })}
            )
        ),
    },
    lua = {
        ls.parser.parse_snippet("lf", "local $1 = function($2)\n\t$0\nend")
    },
    cs = {
        s("controller",
            fmt([[
            using Microsoft.AspNetCore.Mvc;

            namespace {}.Controllers;

            [ApiController]
            [Route("[controller]")]
            public class {}Controller: ControllerBase
            {{
                public {}Controller(ILogger<{}Controller> logger)
                {{
                    // this is my logger
                }}
            }}
            ]], {
                f(function()
                    local cwd = vim.split(vim.loop.cwd(), "/", true)
                    local proj = cwd[#cwd] or "Changeme"
                    return proj:gsub("-", "_")
                end),
                i(1), same(1), same(1)})
        )
    }
})
