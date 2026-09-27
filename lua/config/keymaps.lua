-- KEYMAPS
-- Escape shortcuts
vim.keymap.set('i', 'jk', '<Esc>', { desc = "Exit insert mode" }) 
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = "Exit terminal mode" }) 

-- Window shortcuts
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = "Move to the left window" }) 
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = "Move to the lower window" }) 
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = "Move to the upper window" }) 
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = "Move to the right window" }) 

-- Explore shortcuts
vim.keymap.set('n', '<leader>e', '<cmd>NvimTreeToggle<CR>', { desc = "Toggle file explorer" }) 

-- Lsp shortcuts
vim.keymap.set('i', '<C-Space>', function()
	vim.lsp.completion.get()
end, { desc = "Trigger LSP completion" })
vim.keymap.set("n", "<leader>cf", function()
	vim.lsp.buf.format()
end, { desc = "Format code" })

-- fzf shortcuts
vim.keymap.set('n', '<leader>ff', '<cmd>FzfLua files<CR>',
	{ desc = "Find files" }) 
vim.keymap.set('n', '<leader>fg', '<cmd>FzfLua live_grep<CR>',
	{ desc = "Find text" }) 
vim.keymap.set('n', '<leader>fb', '<cmd>FzfLua buffers<CR>',
	{ desc = "Find buffers" }) 
