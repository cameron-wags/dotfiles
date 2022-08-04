local function map(mode, bind, action, opts)
    opts = opts or { noremap = true }
    vim.keymap.set(mode, bind, action, opts)
end

--Remap space as leader key
map("", "<Space>", "<Nop>", { noremap = true, silent = true })
vim.g.mapleader = " "

--Clear hlsearch with return
map("n", "<CR>", ":noh<CR>")

-- Linewise toggle current line using C-/
map('n', '<C-/>', require("Comment.api").toggle_current_linewise)
-- Linewise toggle using C-/
map('x', '<C-/>', '<ESC><CMD>lua require("Comment.api").toggle_linewise_op(vim.fn.visualmode())<CR>')

-- Disable Arrow keys in Normal mode
map("", "<up>", "")
map("", "<down>", "")
map("", "<left>", "")
map("", "<right>", "")

-- Disable Arrow keys in Insert mode
map("i", "<up>", "")
map("i", "<down>", "")
map("i", "<left>", "")
map("i", "<right>", "")

-- Buffer cycle
map("n", "<S-TAB>", ":bnext<CR>")
map("n", "<C-S-TAB>", ":bprevious<CR>")
-- map("n", "<M-q>", ":bdelete<CR>")
map("n", "<C-q>", ":bdelete<CR>")
map("n", "<leader>q", ":bdelete!<CR>")
map("n", "<C-s>", ":w<CR>")
map("n", "<leader>t", ":enew<CR>")

-- Resize with arrows
map("n", "<C-Up>", ":resize +2<CR>")
map("n", "<C-Down>", ":resize -2<CR>")
map("n", "<C-Left>", ":vertical resize -2<CR>")
map("n", "<C-Right>", ":vertical resize +2<CR>")

-- Stay in indent mode
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Telescope formatters
map("n", "<leader>fr", require('telescope.builtin').oldfiles)
map("n", "<leader>fc", require('telescope.builtin').colorscheme)
map("n", "<leader>fg", require('telescope.builtin').live_grep)
map("n", "<leader>fh", require('telescope.builtin').help_tags)

-- Moving the selected line from Visual Mode
map('v', 'J', ":m '>+1<CR>gv=gv")
map('v', 'K', ":m '<-2<CR>gv=gv")

-- Nvim Tree
map("n", "<M-e>", ":NvimTreeToggle<CR>")
map("n", "<leader>e", ":NvimTreeToggle<CR>")
-- map("n", "<leader>e", ":NvimTreeFocus<CR>", { noremap = true })

-- FZF
-- map("", "<leader>.", ":Files<CR>")
-- map("", "<leader>,", ":Buffers<CR>")
-- map("n", "<leader>g", ":Rg<CR>")
-- map("n", "<leader>t", ":Tags<CR>")
-- map("n", "<leader>m", ":Marks<CR>")

