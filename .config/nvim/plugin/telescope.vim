" Config
lua << EOF
require('telescope').setup {
    defaults = {
        prompt_prefix = "-> ",
        selection_caret = "> ",
        file_previewer = require'telescope.previewers'.cat.new,
        file_ignore_patterns = {
            ".git/",
            "plugged/",
            "node_modules/"
        }
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

" Mappings
nnoremap <C-_> :lua require('telescope.builtin').current_buffer_fuzzy_find({sorting_strategy="ascending", layout_config={prompt_position="top"}})<CR>
nnoremap <Leader>ps :lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ")})<CR> 
nnoremap <Leader>lg :lua require('telescope.builtin').live_grep()<CR>
nnoremap <Leader>gf :lua require('telescope.builtin').git_files()<CR>
nnoremap <Leader>ff :lua require('telescope.builtin').find_files()<CR>
nnoremap <Leader>df :lua require("telescope.builtin").find_files({ prompt_title = "< DotFiles >", cwd = "~/Dev/dotfiles", hidden = true, })<CR>
nnoremap <Leader>bf :lua require('telescope.builtin').buffers()<CR>
nnoremap <Leader>fb :lua require('telescope.builtin').file_browser()<CR>
" LSP
nnoremap <Leader>rf :lua require('telescope.builtin').lsp_references()<CR>
