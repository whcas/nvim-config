-- Minimal local Ollama setup for the Parrot experiment.
-- Only the localhost provider is configured; no cloud credentials or providers.
require("parrot").setup({
	providers = {
		ollama = {
			name = "ollama",
			endpoint = "http://127.0.0.1:11434/api/chat",
			api_key = "",
			models = { "qwen3.6:35b" },
			params = {
				chat = { temperature = 0.6, num_ctx = 16384 },
				command = { temperature = 0.6, num_ctx = 16384 },
			},
			topic = { model = "qwen3.6:35b", params = { max_tokens = 32 } },
			headers = { ["Content-Type"] = "application/json" },
			resolve_api_key = function()
				return true
			end,
			process_stdout = function(response)
				if response:match("message") and response:match("content") then
					local ok, data = pcall(vim.json.decode, response)
					if ok and data.message and data.message.content then
						return data.message.content
					end
				end
			end,
		},
	},
})
