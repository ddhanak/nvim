local status_ok, cmp = pcall(require, "cmp")
if not status_ok then
	return
end

vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.shortmess:append("c")

local has_words_before = function()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

cmp.setup({
	snippet = {
		-- REQUIRED - you must specify a snippet engine
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
			-- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
			-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
			-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
		end,
	},
	mapping = {
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.close(),
		["<CR>"] = cmp.mapping.confirm({
			select = true,
		}),

		-- vsnip 2
		--
		--
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif vim.fn["vsnip#available"](1) == 1 then
				feedkey("<Plug>(vsnip-expand-or-jump)", "")
			elseif has_words_before() then
				cmp.complete()
			else
				fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
			end
		end, { "i", "s" }),

		["<S-Tab>"] = cmp.mapping(function()
			if cmp.visible() then
				cmp.select_prev_item()
			elseif vim.fn["vsnip#jumpable"](-1) == 1 then
				feedkey("<Plug>(vsnip-jump-prev)", "")
			end
		end, { "i", "s" }),

		-- -- vsnip
		-- ["<Tab>"] = cmp.mapping(function(fallback)
		-- 	if cmp.visible() then
		-- 		cmp.select_next_item()
		-- 	elseif vim.fn["vsnip#available"]() == 1 then
		-- 		feedkey("<Plug>(vsnip-expand-or-jump)", "")
		-- 	elseif has_words_before() then
		-- 		cmp.complete()
		-- 	else
		-- 		fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
		-- 	end
		-- end, { "i", "s" }),
		-- ["<S-Tab>"] = cmp.mapping(function()
		-- 	if cmp.visible() then
		-- 		cmp.select_prev_item()
		-- 	elseif vim.fn["vsnip#jumpable"](-1) == 1 then
		-- 		feedkey("<Plug>(vsnip-jump-prev)", "")
		-- 	end
		-- end, { "i", "s" }),
	},
	sources = {
		{
			name = "nvim_lsp",
		},
		{
			name = "nvim_lua",
		},
		{
			name = "buffer",
			keyword_length = 5,
		},
		{
			name = "vsnip",
		},
		{
			name = "path",
		},
	},
})
