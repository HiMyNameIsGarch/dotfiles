local ls = require "luasnip"
local types = require "luasnip.util.types"

ls.config.set_config {
    history = true,
    updateenvent = "TextChanged,TextChangedI",
    enable_autosnippets = true,
    ext_opts = nil
}

ls.snippets = {
    all = {
        ls.parser.parse_snippet("expand", "Blyat what the fuck is this")
    }
}
