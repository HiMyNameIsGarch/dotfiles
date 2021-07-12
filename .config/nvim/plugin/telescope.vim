" Config
lua << EOF
require('telescope').setup {
    defaults = {
        prompt_prefix = "-> ",
        selection_caret = "> ",
        file_previewer = require'telescope.previewers'.vim_buffer_cat.new
    },
    extensions = {
        fzy_native = {
          fuzzy = true,
          override_generic_sorter = false,
          override_file_sorter = true,
          case_mode = "smart_case",
        }
    }
}
require('telescope').load_extension('fzy_native')
EOF
