vim.api.nvim_exec(
	[[
		augroup jdtls_lsp
			autocmd!
			autocmd FileType java lua require("lsp.java").setup()
		augroup end
	]],
	true
)

local api = vim.api
local lsp = vim.lsp
local uv = vim.loop
local path = require('jdtls.path')

local M = {}

function M.find_root(markers, bufname)
	bufname = bufname or api.nvim_buf_get_name(api.nvim_get_current_buf())
	local dirname = vim.fn.fnamemodify(bufname, ':p:h')

	local getparent = function(p)
		return vim.fn.fnamemodify(p, ':h')
	end

	while getparent(dirname) ~= dirname do
		for _, marker in ipairs(markers) do
			if dirname:sub(-string.len(marker)) == marker then
				return dirname
			end
		end
		dirname = getparent(dirname)
	end
end

function M.setup()
	local build_src_dir = M.find_root( { "buildSrc" })

	local root_dir = nil

	if build_src_dir == nil then
		root_dir = require("jdtls.setup").find_root({ "gradlew", "mvnw" })
	else
		root_dir = build_src_dir
	end
	
	if root_dir == nil then
		return
	end

	local on_attach = function(client, bufnr)
		require("jdtls.setup").add_commands()
	end

	local extra_capabilities = {
		workspace = {
			configuration = true
		};

		textDocument = {
			completion = {
				completionItem = {
					snippetSupport = true
				}
			};
		}
	}

	local capabilities = vim.tbl_deep_extend('keep', extra_capabilities,vim.lsp.protocol.make_client_capabilities())
	local home = os.getenv('HOME')
	local workspace_folder = home .. "/.workspace" .. string.gsub(root_dir, "/", "." )
	local config = {
		flags = {
			allow_incremental_sync = true,
		};
		capabilities = capabilities,
		on_attach = on_attach,
		settings = {
			['java.settings.url'] = home .. "/.config/eclipse/settings.pref",
			['java.format.settings.profile'] = "GoogleStyle",
			['java.format.settings.url'] = home .. "/.config/eclipse-formatter.xml",

			java = {
				signatureHelp = { enabled = true };

				contentProvider = { preferred = 'fernflower' };

				sources = {
					organizeImports = {
						starThreshold = 9999;
						staticStarThreshold = 9999;
					};
				};

				codeGeneration = {
					toString = {
						template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}"
					}
				};

				configuration = {
					runtimes = { }
				};
			};
		}
	}
	
	config.root_dir = root_dir
	config.cmd = { "java-lsp", workspace_folder }
	config.on_init = function(client, _)
		client.notify("workspace/didChangeConfiguration", { settings = config.settings })
	end


	local extendedClientCapabilities = require("jdtls").extendedClientCapabilities
	extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

	config.init_options = {
		extendedClientCapabilities = extendedClientCapabilities;
		languageFeatures = {
			codeLens = false
		}
	}

	require('jdtls').start_or_attach(config)
end

return M
