-- Plugins
vim.pack.add({
	{ src = "https://github.com/nvim-tree/nvim-tree.lua" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	{ src = "https://github.com/catppuccin/nvim" },
	{ src = "https://github.com/ibhagwan/fzf-lua" },
	{ src = "https://github.com/saghen/blink.lib" },
	{ src = "https://github.com/saghen/blink.cmp" },
	{ src = "https://github.com/lewis6991/gitsigns.nvim" },
	{ src = "https://github.com/nvim-mini/mini.pairs" },
})

-- Nvim-Tree
require("nvim-tree").setup()

-- Nvim-Treesitter
require("nvim-treesitter").install({ "rust" })

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "rust" },
	callback = function()
		vim.treesitter.start()
	end
})

-- Catppuccin
vim.cmd.colorscheme("catppuccin-mocha")

-- fzf-lua
require("fzf-lua").setup({})

-- blink
local cmp = require("blink.cmp")
cmp.build():pwait()
cmp.setup()

-- mini-pairs
require("mini.pairs").setup()
