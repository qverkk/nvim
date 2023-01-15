local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.ensure_installed({
	"sumneko_lua",
	"rust_analyzer",
	"kotlin_language_server",
	"yamlls",
	"jsonls",
	"dockerls"
})

lsp.setup()
