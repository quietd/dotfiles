local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', function()
    builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)
vim.keymap.set('n', '<leader>h', builtin.help_tags)

vim.keymap.set("n", "<leader>do", function()
    builtin.find_files({
        cwd = "~/dotfiles",
        hidden = true,
        find_command = { "rg", "--files", "--hidden", "--glob", "!.git/*" }
    })
end, { desc = "Find files in dotfiles directory" })


require('telescope').setup {
    extensions = {
        fzf = {
            fuzzy = true,                   -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true,    -- override the file sorter
            case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
            config = function()
                require('telescope').setup({
                    pickers = {
                        find_files = {
                            theme = "ivy",
                        },
                    },
                })
            end,
        }
    }
}

require('telescope').setup({
    pickers = {
        find_files = {
            -- theme = "cursor",
        },
    },
})

require('telescope').load_extension('fzf')
