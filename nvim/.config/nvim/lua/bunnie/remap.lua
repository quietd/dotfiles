vim.g.mapleader = " "
-- vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
-- vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set("n", "<leader>rc", "<cmd>e ~/.config/nvim/lua/bunnie/lazy.lua<CR>")
vim.keymap.set("n", "<leader>ih", "<cmd>e ~/.config/hypr/hyprland.lua<CR>")
vim.keymap.set("n", "<leader>i3", "<cmd>e ~/.config/i3/config<CR>")

vim.keymap.set('n', '<leader>w', function()
    vim.opt.wrap = not vim.opt.wrap:get()
end, { desc = "Toggle Line Wrap" })

vim.opt.linebreak = true

vim.keymap.set("n", "j", "gj", { noremap = true, silent = true })
vim.keymap.set("n", "k", "gk", { noremap = true, silent = true })
vim.keymap.set("v", "j", "gj", { noremap = true, silent = true })
vim.keymap.set("v", "k", "gk", { noremap = true, silent = true })

vim.keymap.set("i", "<M-h>", "<Left>", { noremap = true, silent = true })
vim.keymap.set("i", "<M-j>", "<Down>", { noremap = true, silent = true })
vim.keymap.set("i", "<M-k>", "<Up>", { noremap = true, silent = true })
vim.keymap.set("i", "<M-l>", "<Right>", { noremap = true, silent = true })

vim.keymap.set("n", "<A-h>", "<C-W>h")
vim.keymap.set("n", "<A-j>", "<C-W>j")
vim.keymap.set("n", "<A-k>", "<C-W>k")
vim.keymap.set("n", "<A-l>", "<C-W>l")

vim.keymap.set("n", "<A-Up>", ":resize +2<CR>", { desc = "Increase window height" })
vim.keymap.set("n", "<A-Down>", ":resize -2<CR>", { desc = "Decrease window height" })
vim.keymap.set("n", "<A-Left>", ":vertical resize -2<CR>", { desc = "Decrease window width" })
vim.keymap.set("n", "<A-Right>", ":vertical resize +2<CR>", { desc = "Increase window width" })

vim.keymap.set("n", "<leader>t", "<cmd>vsplit term://%:p:h//zsh<CR>")
vim.keymap.set("n", "<leader>n", "<cmd>e ~/notes<CR>")

vim.api.nvim_create_user_command('Daily', function()
  local date = os.date("%Y-%m-%d")
  local dir = "~/notes/journal/"
  local path = dir .. date .. ".md"
  vim.fn.mkdir(vim.fn.expand(dir), "p")
  vim.cmd("edit " .. path)
end, {})

vim.keymap.set('n', '<leader>jn', ':Daily<CR>', { desc = "Open today's journal" })

