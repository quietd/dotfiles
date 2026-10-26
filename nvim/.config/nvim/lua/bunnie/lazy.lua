local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        'git', 'clone', '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git', '--branch=stable', lazypath
    })
end

vim.opt.rtp:prepend(lazypath)

require('lazy').setup({

    --LSP stuff
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            "folke/lazydev.nvim",
            ft = "lua", -- only load on lua files
            opts = {
                library = {
                    -- See the configuration section for more details
                    -- Load luvit types when the `vim.uv` word is found
                    { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                },
            },
        },
    },
    { 'williamboman/mason.nvim' },
    { 'williamboman/mason-lspconfig.nvim' },
    { 'hrsh7th/nvim-cmp' },
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'L3MON4D3/LuaSnip' },
    { 'saadparwaiz1/cmp_luasnip' },
    { 'rafamadriz/friendly-snippets' },
    {
        'chomosuke/typst-preview.nvim',
        ft = 'typst',
        version = '1.*',
        opts = {}, -- lazy.nvim will implicitly calls `setup {}`
    },
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.8',
        dependencies = {
            'nvim-lua/plenary.nvim',
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
        }
    },
    {
        'lukas-reineke/indent-blankline.nvim',
        main = "ibl",
        opts = {}
    },
    {
        'nvim-treesitter/nvim-treesitter',
        branch = "main",
        build = ':TSUpdate'
    },
    { 'mbbill/undotree' },
    { 'tpope/vim-fugitive' },
    { 'nvim-treesitter/nvim-treesitter-context' },
    { 'stevearc/oil.nvim' },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = {
            'nvim-tree/nvim-web-devicons',
            config = function()
                require('lualine').setup({
                    options = { theme = require('lualine.themes._black_metal').get() }
                })
            end
        }
    },
    {
        'kylechui/nvim-surround',
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end
    },
    {
        'numToStr/Comment.nvim',
        opts = {},
    },
    {
        "metalelf0/black-metal-theme-neovim",
        lazy = false,
        priority = 1000,
        config = function()
            require("black-metal").setup({
                code_style = {
                    comments = "bold"
                },
                theme = "bathory",
            })
            require("black-metal").load()
        end,
    },

    {
        "epwalsh/obsidian.nvim",
        version = "*",
        lazy = true,
        ft = "markdown",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {
            workspaces = {
                { name = "notes", path = "~/notes" },
            },
            daily_notes = {
                folder = "daily",
                date_format = "%Y-%m-%d",
            },
            study_notes = {
                folder = "learning",
            },
            completion = {
                nvim_cmp = true, -- set false if you don't use nvim-cmp
            },
        },
    }
})
