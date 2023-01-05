require("null-ls").setup({
	sources = {
		require("null-ls").builtins.formatting.stylua,
		require("null-ls").builtins.formatting.shfmt,
		require("null-ls").builtins.formatting.rustfmt,
		require("null-ls").builtins.formatting.markdownlint,
		-- require("null-ls").builtins.formatting.prettier,
		require("null-ls").builtins.formatting.black.with({ extra_args = { "--fast", "--line-length=160" } }),
		require("null-ls").builtins.formatting.isort.with({ extra_args = { "--profile=black" } }),
		require("null-ls").builtins.diagnostics.cfn_lint,
		require("null-ls").builtins.diagnostics.yamllint,
	},
})
