local opts = { noremap = true, silent = true }

-- delete a word backwards
vim.keymap.set("n", "db", 'vb"_d')

-- select all
vim.keymap.set("n", "<c-a>", "gg<s-v>g")

vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = "copy to system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>p", '"+p', { desc = "paste from system clipboard" })

-- better window management

vim.keymap.set("n", "hs", ":split<return>", opts)
vim.keymap.set("n", "vs", ":vsplit<return>", opts)
vim.keymap.set("n", "<c-h>", "<c-w>h", { desc = "move to left split" })
vim.keymap.set("n", "<c-j>", "<c-w>j", { desc = "move to below split" })
vim.keymap.set("n", "<c-k>", "<c-w>k", { desc = "move to above split" })
vim.keymap.set("n", "<c-l>", "<c-w>l", { desc = "move to right split" })
vim.keymap.set("n", "<c-up>", "<cmd>resize -2<cr>", { desc = "resize split up" })
vim.keymap.set("n", "<c-down>", "<cmd>resize +2<cr>", { desc = "resize split down" })
vim.keymap.set("n", "<c-left>", "<cmd>vertical resize -2<cr>", { desc = "resize split left" })
vim.keymap.set("n", "<c-right>", "<cmd>vertical resize +2<cr>", { desc = "resize split right" })

-- save and quit

vim.keymap.set("n", "<leader>q", "<cmd>wq!<cr>", { desc = "force save and  quit" })

-- buffers

vim.keymap.set("n", "<leader>q", "<cmd>q!<cr>", { desc = "close buffer/window" })
vim.keymap.set("n", "<s-l>", "<cmd>bnext<cr>", { desc = "go to next buffer" })
vim.keymap.set("n", "<s-h>", "<cmd>bprevious<cr>", { desc = "go to previous buffer" })
vim.keymap.set("n", "]b", "<cmd>bnext<cr>", { desc = "go to next buffer" })
vim.keymap.set("n", "[b", "<cmd>bprevious<cr>", { desc = "go to previous buffer" })

-- visual vim.keymap.sets
vim.keymap.set("v", "<leader>r", '"hy:%s/<c-r>h//g<left><left>') -- replace all instances of highlighted words
vim.keymap.set("v", "<c-s>", ":sort<cr>") -- sort highlighted text in visual mode with control+s
vim.keymap.set("v", "k", ":m '>-2<cr>gv=gv") -- move current line up
vim.keymap.set("v", "j", ":m '>+1<cr>gv=gv") -- move current line down
