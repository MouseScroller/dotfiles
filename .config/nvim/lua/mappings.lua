vim.cmd([[:command WQ wq]])
vim.cmd([[:command Wq wq]])
vim.cmd([[:command W w]])
vim.cmd([[:command Q q]])
vim.cmd([[:command F Format]])

Maps_keys({
	["n"] = {
		["<Space>"] = { "<Nop>", { silent = true } },
		["Mj"] = { ":resize -10<cr>", { desc = "horizontel height decrese" } },
		["Mk"] = { ":resize +10<cr>", { desc = "horizontel height increase" } },
		["Mh"] = { ":vertical resize -10<cr>", { desc = "vertical decrese" } },
		["Ml"] = { ":vertical resize +10<cr>", { desc = "vertical increase" } },
		["<leader><cr>"] = { ":noh<cr>", { desc = "remove highlighting" } },
		["<leader>ss"] = { ":setlocal spell!<cr>", { desc = "add spellchecking" } },

		["+"] = { ":vertical resize +10<cr>", { desc = "vertical resize increase" } },
		["-"] = { ":vertical resize -10<cr>", { desc = "vertical resize decrese" } },

		["<F5>"] = { "<cmd>!builder build run<cr>", { desc = "build and run" } },
		["<F6>"] = { "<cmd>!builder build<cr>", { desc = "build" } },
		["<F7>"] = { "<cmd>!builder run<cr>", { desc = "run" } },

		-- Remap for dealing with word wrap
		["k"] = { "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true } },
		["j"] = { "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true } },

		-- Diagnostic keymaps
		["[d"] = { vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' } },
		["]d"] = { vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' } },
		["<leader>e"] = { vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' } },
		["<leader>q"] = { vim.diagnostic.setloclist, { desc = 'Open diagnostics list' } },

		["<C-h>"] = { "<C-w>h", { desc = 'Move to left window' } },
		["<C-l>"] = { "<C-w>l", { desc = 'Move to right window' } },
		["<C-j>"] = { "<C-w>j", { desc = 'Move to below window' } },
		["<C-k>"] = { "<C-w>k", { desc = 'Move to upper window' } },

	},
	["i"] = {
		["<C-b>"] = { "<ESC>^i", { desc = "Move to the beginning of the line" } },
		["<C-e>"] = { "<End>", { desc = "Move to the end of the line" } },

		["<C-h>"] = { "<Left>", { desc = "Move left" } },
		["<C-l>"] = { "<Right>", { desc = "Move right" } },
		["<C-j>"] = { "<Down>", { desc = "Move down" } },
		["<C-k>"] = { "<Up>", { desc = "Move up" } }
	},
	["t"] = {
		["<Esc>"] = { "<C-\\><C-n>", { desc = "Esc exits terminal mod" } },
		["<C-x>"] = { vim.api.nvim_replace_termcodes("<C-\\><C-N>", true, true, true), {desc = "Escape terminal mode"} },
	},
	["v"] = {
		["<Space>"] = { "<Nop>", { silent = true } },
		-- Indenting
		["<"] = { "<gv", { desc = "incresse Indenting" } },
		[">"] = { ">gv", { desc = "decresse Indenting" } },
	}
})
