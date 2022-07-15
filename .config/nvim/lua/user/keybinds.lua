local map = vim.keymap.set

--Remap space as leader key
map("", "<Space>", "<Nop>", { noremap = true, silent = true })
vim.g.mapleader = " "

--Clear hlsearch with return
map("n", "<CR>", ":noh<CR>", { noremap = true })

-- Linewise toggle current line using C-/
map('n', '<C-/>', require("Comment.api").toggle_current_linewise, { noremap = true })
-- Linewise toggle using C-/
map('x', '<C-/>', '<ESC><CMD>lua require("Comment.api").toggle_linewise_op(vim.fn.visualmode())<CR>', { noremap = true })

-- Disable Arrow keys in Normal mode
map("", "<up>", "", { noremap = false })
map("", "<down>", "", { noremap = false })
map("", "<left>", "", { noremap = false })
map("", "<right>", "", { noremap = false })

-- Disable Arrow keys in Insert mode
map("i", "<up>", "", { noremap = false })
map("i", "<down>", "", { noremap = false })
map("i", "<left>", "", { noremap = false })
map("i", "<right>", "", { noremap = false })

-- Buffer cycle
map("n", "<S-TAB>", ":bnext<CR>", { noremap = true })
map("n", "<C-S-TAB>", ":bprevious<CR>", { noremap = true })
-- map("n", "<M-q>", ":bdelete<CR>", { noremap = true })
map("n", "<C-q>", ":bdelete<CR>", { noremap = true })
map("n", "<leader>q", ":bdelete<CR>", { noremap = true })
map("n", "<C-s>", ":w<CR>", { noremap = true })

-- Resize with arrows
map("n", "<C-Up>", ":resize +2<CR>", { noremap = true })
map("n", "<C-Down>", ":resize -2<CR>", { noremap = true })
map("n", "<C-Left>", ":vertical resize -2<CR>", { noremap = true })
map("n", "<C-Right>", ":vertical resize +2<CR>", { noremap = true })

-- Stay in indent mode
map("v", "<", "<gv", {noremap = true})
map("v", ">", ">gv", {noremap = true})

-- Telescope formatters
map("n", "<leader>fr", require('telescope.builtin').oldfiles, { noremap = true })
map("n", "<leader>fc", require('telescope.builtin').colorscheme, { noremap = true })
map("n", "<leader>fg", require('telescope.builtin').live_grep, { noremap = true })
map("n", "<leader>fh", require('telescope.builtin').help_tags, { noremap = true })

-- Moving the selected line from Visual Mode
map('v', 'J', ":m '>+1<CR>gv=gv", {noremap = true})
map('v', 'K', ":m '<-2<CR>gv=gv", {noremap = true})

-- Nvim Tree
map("n", "<M-e>", ":NvimTreeToggle<CR>", { noremap = true })
map("n", "<leader>e", ":NvimTreeToggle<CR>", { noremap = true })
-- map("n", "<leader>e", ":NvimTreeFocus<CR>", { noremap = true })

-- FZF
map("", "<leader>.", ":Files<CR>", { noremap = false })
map("", "<leader>,", ":Buffers<CR>", { noremap = false })
map("n", "<leader>g", ":Rg<CR>", { noremap = true })
map("n", "<leader>t", ":Tags<CR>", { noremap = true })
map("n", "<leader>m", ":Marks<CR>", { noremap = true })

