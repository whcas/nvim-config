-- KEYMAPS
-- Escape shortcuts
vim.keymap.set('i', 'jk', '<Esc>', { desc = "Exit insert mode" }) 
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = "Exit terminal mode" }) 

-- Window shortcuts
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = "Move to the left window" }) 
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = "Move to the lower window" }) 
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = "Move to the upper window" }) 
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = "Move to the right window" }) 
vim.keymap.set('t', '<C-h>', '<C-\\><C-n><C-w>h', { desc = "Move to the left window" }) 
vim.keymap.set('t', '<C-j>', '<C-\\><C-n><C-w>j', { desc = "Move to the lower window" }) 
vim.keymap.set('t', '<C-k>', '<C-\\><C-n><C-w>k', { desc = "Move to the upper window" }) 
vim.keymap.set('t', '<C-l>', '<C-\\><C-n><C-w>l', { desc = "Move to the right window" }) 

-- UI shortcuts
vim.keymap.set('n', '<leader>uw', '<cmd>set wrap!<CR>',
	{ desc = "Toggle line wrapping" })

-- Explore shortcuts
vim.keymap.set('n', '<leader>e', '<cmd>NvimTreeToggle<CR>', { desc = "Toggle file explorer" }) 

-- File shortcuts
vim.keymap.set({'n', 'i'}, '<C-s>', '<cmd>write<CR>', { desc = "Save file" })

-- Lsp shortcuts
vim.keymap.set("n", "<leader>cf", function()
	vim.lsp.buf.format()
end, { desc = "Format code" })

-- Local Ollama chat (only on the Parrot experiment branch)
vim.keymap.set("n", "<leader>ca", "<cmd>PrtChatToggle vsplit<CR>",
	{ desc = "Toggle AI chat (Parrot)" })
vim.keymap.set("x", "<leader>cs", "<cmd>PrtChatPaste vsplit<CR>",
	{ desc = "Send selection to AI chat" })

-- fzf shortcuts
vim.keymap.set('n', '<leader>ff', '<cmd>FzfLua files<CR>',
	{ desc = "Find files" }) 
vim.keymap.set('n', '<leader>fg', '<cmd>FzfLua live_grep<CR>',
	{ desc = "Find text" }) 
vim.keymap.set('n', '<leader>fb', '<cmd>FzfLua buffers<CR>',
	{ desc = "Find buffers" }) 
