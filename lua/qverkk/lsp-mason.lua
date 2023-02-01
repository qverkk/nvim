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
require("lspconfig").rust_analyzer.setup {}

local java_mappings_on_attach = function(_, _)
	vim.keymap.set("n", "<c-a-v>", "<cmd>lua require('jdtls').extract_variable()<cr>", {})
	vim.keymap.set("n", "<c-a-m>", "<cmd>lua require('jdtls').extract_method()<cr>", {})
end

require("lspconfig").jdtls.setup {
	on_attach = java_mappings_on_attach
}


