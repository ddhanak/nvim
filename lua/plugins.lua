-- Bootstrapping, ensure that packer.nvim is installed
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
	fn.system({ "git", "clone", "https://github.com/wbthomason/packer.nvim", install_path })
	vim.cmd([[packadd packer.nvim]])
end

-- Automatically run :PackerCompile whenever this file is updated
local plugins_path = fn.stdpath("config") .. "/lua/plugins.lua"
vim.cmd("autocmd BufWritePost " .. plugins_path .. " PackerCompile")

require("packer").startup(function(use)
	use("wbthomason/packer.nvim")

	use("nvim-lua/plenary.nvim")
	use({
		"nvim-treesitter/nvim-treesitter",
		config = function()
			require("conf.treesitter")
		end,
	})
	use("nvim-treesitter/playground")
	use("nvim-treesitter/nvim-treesitter-textobjects")

	use("tpope/vim-fugitive")
	use("tpope/vim-rhubarb")
	use("tpope/vim-surround")
	use("tpope/vim-repeat")

	use("lukas-reineke/indent-blankline.nvim")

	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.0",
		requires = { { "nvim-lua/plenary.nvim" } },
	})

	use({
		"catppuccin/nvim",
		as = "catppuccin",
		config = function()
			vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha
			require("catppuccin").setup()
			vim.api.nvim_command("colorscheme catppuccin")
		end,
	})

	use({
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()
		end,
	})

	use({
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup()
		end,
	})

	use({
		"nvim-lualine/lualine.nvim",
		requires = {
			"kyazdani42/nvim-web-devicons",
		},
		config = function()
			require("lualine").setup()
		end,
	})

	use({
		"nvim-tree/nvim-tree.lua",
		requires = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("nvim-tree").setup({
				view = {
					adaptive_size = true,
					width = 45,
				},
			})
		end,
	})

	use({
		"phaazon/hop.nvim",
		branch = "v2", -- optional but strongly recommended
		config = function()
			-- you can configure Hop the way you like here; see :h hop-config
			require("hop").setup({
				keys = "etovxqpdygfblzhckisuran",
			})
		end,
	})

	use({
		"folke/trouble.nvim",
		requires = "kyazdani42/nvim-web-devicons",
		config = function()
			require("trouble").setup({})
		end,
	})

	use({
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	})

	-- lsp config
	use({
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
	})

	-- autocomplete
	use({
		"hrsh7th/nvim-cmp",
		requires = {
			{ "neovim/nvim-lspconfig" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-nvim-lua" },
			{ "hrsh7th/cmp-vsnip" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "f3fora/cmp-spell" },
			{ "rafamadriz/friendly-snippets" },
			{
				"hrsh7th/vim-vsnip",
				config = function()
					vim.g.vsnip_snippet_dir = "$HOME/.config/nvim/vsnip"
				end,
			},
			{ "lukas-reineke/cmp-under-comparator" },
			{ "hrsh7th/cmp-nvim-lsp-signature-help" },
			{ "davidsierradz/cmp-conventionalcommits" },
		},
	})

	use({
		"jose-elias-alvarez/null-ls.nvim",
		requires = { "nvim-lua/plenary.nvim" },
	})

	use({
		"akinsho/bufferline.nvim",
		tag = "v2.*",
		requires = "kyazdani42/nvim-web-devicons",
		config = function()
			require("bufferline").setup({})
		end,
	})

	-- typescript
	use({ "HerringtonDarkholme/yats.vim" })
	use({ "jose-elias-alvarez/typescript.nvim" })

	use({
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	})

	use({
		"akinsho/toggleterm.nvim",
		tag = "*",
		config = function()
			require("conf.toggleterm")
		end,
	})

	-- -- Glow for markdown preview
	-- use({ "ellisonleao/glow.nvim" })

	-- -- vim-easy-align
	-- use({ "junegunn/vim-easy-align" })

	-- -- Debugger
	-- use { 'mfussenegger/nvim-dap' }
	-- use { 'mfussenegger/nvim-dap-python' }
	-- use { 'nvim-telescope/telescope-dap.nvim' }
	-- use { "rcarriga/nvim-dap-ui",
	--     requires = { "mfussenegger/nvim-dap" },
	--     config = function()
	--         require("plugins.core.dap-ui")
	--     end
	-- }
	-- use { 'theHamsta/nvim-dap-virtual-text', config = function()
	--     require("nvim-dap-virtual-text").setup({
	--         commented = true
	--     })
	-- end }
end)

require("conf.lsp")
require("conf.cmp")
require("conf.null-ls")
