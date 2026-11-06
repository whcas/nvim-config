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
	{ src = "https://github.com/folke/which-key.nvim" },
	{ src = "https://github.com/MeanderingProgrammer/render-markdown.nvim" },
	{ src = "https://github.com/frankroeder/parrot.nvim" },
})

-- Nvim-Tree
require("nvim-tree").setup()

-- Nvim-Treesitter
require("nvim-treesitter").install({ "rust", "markdown", "markdown_inline" })

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "rust", "markdown" },
	callback = function()
		vim.treesitter.start()
	end
})

-- Markdown rendering (shared by work-safe and personal branches)
require("render-markdown").setup({})

-- Catppuccin
vim.cmd.colorscheme("catppuccin-mocha")

-- fzf-lua
require("fzf-lua").setup({})

-- blink
local cmp = require("blink.cmp")
cmp.build():pwait()
cmp.setup({
	keymap = {
		preset = "enter"
	}
})

-- mini-pairs
require("mini.pairs").setup()

-- which-key
require("which-key").setup({
	triggers = {
		{ "<leader>", mode = { "n", "v" } },
		{ "g", mode = { "n", "v" } },
	},
	spec = {
		{ "<leader>f", group = "find" },
		{ "<leader>c", group = "code" },
		{ "<leader>h", group = "git" },
		{ "<leader>u", group = "ui" },
	},
})
