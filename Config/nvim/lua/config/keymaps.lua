local opts = { noremap = true, silent = true }

-- Delete a word backwards
vim.keymap.set("n", "db", 'vb"_d')

-- Select all
vim.keymap.set("n", "<C-s>", "gg<S-v>G")

vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = "Copy to system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>p", '"+p', { desc = "Paste from system clipboard" })

-- Better window management

vim.keymap.set("n", "hs", ":split<Return>", opts)
vim.keymap.set("n", "vs", ":vsplit<Return>", opts)
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left split" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to below split" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to above split" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right split" })
vim.keymap.set("n", "<C-Up>", "<cmd>resize -2<CR>", { desc = "Resize split up" })
vim.keymap.set("n", "<C-Down>", "<cmd>resize +2<CR>", { desc = "Resize split down" })
vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<CR>", { desc = "Resize split left" })
vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<CR>", { desc = "Resize split right" })

-- save and quit

vim.keymap.set("n", "<leader>Q", "<cmd>wq!<CR>", { desc = "Force save and  quit" })

-- Buffers

vim.keymap.set("n", "<leader>q", "<cmd>q!<CR>", { desc = "Close buffer/window" })
vim.keymap.set("n", "<S-l>", "<cmd>bnext<CR>", { desc = "Go to next buffer" })
vim.keymap.set("n", "<S-h>", "<cmd>bprevious<CR>", { desc = "Go to previous buffer" })
vim.keymap.set("n", "]b", "<cmd>bnext<CR>", { desc = "Go to next buffer" })
vim.keymap.set("n", "[b", "<cmd>bprevious<CR>", { desc = "Go to previous buffer" })

-- Visual vim.keymap.sets
vim.keymap.set("v", "<leader>r", '"hy:%s/<C-r>h//g<left><left>') -- Replace all instances of highlighted words
vim.keymap.set("v", "<C-s>", ":sort<CR>") -- Sort highlighted text in visual mode with Control+S
vim.keymap.set("v", "K", ":m '>-2<CR>gv=gv") -- Move current line up
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv") -- Move current line down
