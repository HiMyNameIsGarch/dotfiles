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

local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- Maps
keymap.set('n', '<C-_>', function ()
    require('telescope.builtin').current_buffer_fuzzy_find({sorting_strategy="ascending", layout_config={prompt_position="top"}})
end , opts)

keymap.set('n', '<leader>ff', function ()
    require('telescope.builtin').find_files() end , opts)

keymap.set('n', '<leader>ps', function ()
    require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ")})
end , opts)

keymap.set('n', '<leader>lg', function ()
    require('telescope.builtin').live_grep() end , opts)

keymap.set('n', '<leader>gf', function ()
    require('telescope.builtin').git_files() end , opts)

keymap.set('n', '<leader>df', function ()
    require("telescope.builtin").find_files({ prompt_title = "< DotFiles >", cwd = "~/Dev/dotfiles", hidden = true, })
end , opts)

keymap.set('n', '<leader>bf', function ()
    require('telescope.builtin').buffers() end , opts)

keymap.set('n', '<leader>fb', function ()
    require('telescope.builtin').file_browser() end , opts)
