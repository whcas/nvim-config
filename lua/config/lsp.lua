-- Nvim-lspconfig
vim.lsp.enable("rust_analyzer")

vim.diagnostic.config({
	virtual_text = true,
})

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*.rs",
	callback = function(ev)
		vim.lsp.buf.format({
			bufnr = ev.buf,
			timeout_ms = 1000,
		})
	end,
})
