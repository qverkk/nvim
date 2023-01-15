local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.ensure_installed({
	"sumneko_lua",
	"rust_analyzer",
	"kotlin_language_server",
	"yamlls",
	"jsonls",
	"dockerls",
})

local cmp = require("cmp")
local cmp_mappings = lsp.defaults.cmp_mappings({
	["<C-Space>"] = cmp.mapping.complete(),
	["<C-e>"] = cmp.mapping.abort(),
})

-- disable completion with tab
cmp_mappings["<Tab>"] = nil
cmp_mappings["<S-Tab>"] = nil

lsp.set_preferences({
	set_lsp_keymaps = false,
})

lsp.setup_nvim_cmp({
	mapping = cmp_mappings,
})

lsp.setup()
