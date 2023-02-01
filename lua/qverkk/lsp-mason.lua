require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = {
		"sumneko_lua",
		"jdtls",
		"kotlin_language_server",
		"rust_analyzer"
	}
})

require("lspconfig").sumneko_lua.setup {}
require("lspconfig").kotlin_language_server.setup {}
require("lspconfig").jdtls.setup {}
require("lspconfig").rust_analyzer.setup {}

