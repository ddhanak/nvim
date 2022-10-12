local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts)

local on_attach = function(client, bufnr)
	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
	vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
	vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
	vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)

	vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
	vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
	vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
	vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)

	vim.keymap.set("n", "<space>gf", function()
		vim.lsp.buf.format({ async = true })
	end, bufopts)

	vim.keymap.set("n", "<space>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, bufopts)
end

local on_attach_no_formatting = function(client, bufnr)
	client.server_capabilities.documentFormattingProvider = false
	client.server_capabilities.documentRangeFormattingProvider = false
	on_attach(client, bufnr)
end

local on_attach_formatting = function(client, bufnr)
	client.server_capabilities.documentFormattingProvider = true
	on_attach(client, bufnr)
end

require("mason").setup()
require("mason-lspconfig").setup()

local lsp_flags = {
	-- This is the default in Nvim 0.7+
	debounce_text_changes = 150,
}
require("lspconfig")["sumneko_lua"].setup({
	on_attach = on_attach_no_formatting,
	flags = lsp_flags,
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
		},
	},
})
require("lspconfig")["tsserver"].setup({
	on_attach = on_attach_no_formatting,
	flags = lsp_flags,
})
require("lspconfig")["eslint"].setup({
	capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities()),
	on_attach = on_attach_formatting,
	-- on_attach = function(client, bufnr)
	-- 	client.server_capabilities.documentFormattingProvider = true
	-- 	if client.server_capabilities.documentFormattingProvider then
	-- 		local au_lsp = vim.api.nvim_create_augroup("eslint_lsp", { clear = true })
	-- 		vim.api.nvim_create_autocmd("BufWritePre", {
	-- 			pattern = "*",
	-- 			callback = function()
	-- 				vim.lsp.buf.format({ async = true })
	-- 			end,
	-- 			group = au_lsp,
	-- 		})
	-- 	end
	-- end,
	flags = lsp_flags,
})
require("lspconfig")["pyright"].setup({
	on_attach = on_attach,
	flags = lsp_flags,
})