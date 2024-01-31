local telescope = require("telescope")

telescope.setup {
    defaults = {
        prompt_prefix = "-> ",
        selection_caret = "> ",
        file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
        file_ignore_patterns = {
            ".git/",
            "plugged/",
            "node_modules/",
            "undodir/"
        }
    },
    extensions = {
        fzy_native = {
          fuzzy = true,
          override_generic_sorter = false,
          override_file_sorter = true,
          case_mode = "smart_case"
        }
    }
}
telescope.load_extension('fzy_native')

-- Maps
local bind = require("keymap").bind
local map = bind('n', {noremap = true, silent = true})

map('<C-_>', function ()
    require('telescope.builtin').current_buffer_fuzzy_find({sorting_strategy="ascending", layout_config={prompt_position="top"}})
end)
map('<leader>ff', require('telescope.builtin').find_files)
map('<leader>ps', function ()
    require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ")})
end)
map('<leader>td', function ()
    require('telescope.builtin').grep_string({ search = "TODO"})
end)
map('<leader>lg', require('telescope.builtin').live_grep)
map('<leader>gf', require('telescope.builtin').git_files)
map('<leader>df', function ()
    require("telescope.builtin").find_files({ prompt_title = "< DotFiles >", cwd = "~/Dev/dotfiles", hidden = true, })
end)
-- Not just files, you know?
map('<leader>bf', require('telescope.builtin').buffers)
map('<leader>km', require('telescope.builtin').keymaps)
map('<leader>h', require('telescope.builtin').help_tags)
map('<leader>mp', require('telescope.builtin').man_pages)
