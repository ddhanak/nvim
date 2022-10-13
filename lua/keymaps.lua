-- default
vim.api.nvim_set_keymap("n", "<ESC>", ":noh<CR>", { silent = true })

-- nvim tree
vim.api.nvim_set_keymap("n", "<C-n>", ":NvimTreeToggle<CR>", { silent = true })

-- telescope
vim.api.nvim_set_keymap("n", "<leader>ff", "<cmd>lua require('telescope.builtin').find_files()<cr>", { silent = true })
vim.api.nvim_set_keymap("n", "<leader>fg", "<cmd>lua require('telescope.builtin').live_grep()<cr>", { silent = true })
vim.api.nvim_set_keymap("n", "<leader>fb", "<cmd>lua require('telescope.builtin').buffers()<cr>", { silent = true })
vim.api.nvim_set_keymap("n", "<leader>fh", "<cmd>lua require('telescope.builtin').help_tags()<cr>", { silent = true })

-- fugitive
vim.api.nvim_set_keymap("n", "<leader>gs", ":Git<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<leader>gp", ":Git push<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<leader>gb", ":Git blame<CR>", { silent = true })

-- hop
vim.api.nvim_set_keymap("n", "<leader>hw", ":HopWord<CR>", { silent = true })

-- trouble
vim.api.nvim_set_keymap("n", "<leader>xx", "<cmd>Trouble<cr>", { silent = true })

-- bufferline
vim.api.nvim_set_keymap("n", "[b", ":BufferLineCycleNext<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "]b", ":BufferLineCyclePrev<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<leader>bdr", ":BufferLineCloseRight<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<leader>bdl", ":BufferLineCloseLeft<CR>", { silent = true })
