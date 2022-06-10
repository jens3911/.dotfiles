local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
	return
end

local lspconfig = require("lspconfig")

local servers = { "jsonls", "sumneko_lua", "tsserver", "gopls", "svelte"}

lsp_installer.setup {
	ensure_installed = servers
}

for _, server in pairs(servers) do
	local opts = {
		on_attach = require("user.lsp.handlers").on_attach,
		capabilities = require("user.lsp.handlers").capabilities,
    root_dir = vim.loop.cwd -- adds lsp without tsconfig,...
	}
	local has_custom_opts, server_custom_opts = pcall(require, "user.lsp.settings." .. server)
	if has_custom_opts then
	 	opts = vim.tbl_deep_extend("force", server_custom_opts, opts)
	end
	lspconfig[server].setup(opts)
end
lspconfig.gopls.setup{
	on_attach = on_attach_vim,
	capabilities = capabilities,
	cmd = {"gopls", "serve"},
	settings = {
		gopls = {
			analyses = {
				unusedparams = true,
			},
			staticcheck = true,
			linksInHover = false,
			codelenses = {
				generate = true,
				gc_details = true,
				regenerate_cgo = true,
				tidy = true,
				upgrade_depdendency = true,
				vendor = true,
			},
			usePlaceholders = true,
		},
	},
}

-- lsp_installer.tsserver.setup {on_attach = custom_attach, root_dir = vim.loop.cwd }
