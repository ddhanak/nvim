require("null-ls").setup({
	sources = {
		require("null-ls").builtins.formatting.stylua,
		require("null-ls").builtins.formatting.black.with({ extra_args = { "--fast", "--line-length=160" } }),
		require("null-ls").builtins.formatting.isort.with({ extra_args = { "--profile=black" } }),
	},
})
