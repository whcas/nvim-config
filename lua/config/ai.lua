-- Local LLM integration for the ai branch.
-- Requires Ollama running on localhost with qwen3.6:35b installed.
local ollama = {
	name = "ollama",
	model = "qwen3.6:35b",
}

require("codecompanion").setup({
	interactions = {
		chat = { adapter = ollama },
		inline = { adapter = ollama },
		cmd = { adapter = ollama },
		background = { adapter = ollama },
	},
})

-- CodeCompanion uses its own filetype for Markdown chat buffers.
vim.treesitter.language.register("markdown", "codecompanion")
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "markdown", "codecompanion" },
	callback = function()
		pcall(vim.treesitter.start)
	end,
})

require("render-markdown").setup({
	file_types = { "markdown", "codecompanion" },
})
