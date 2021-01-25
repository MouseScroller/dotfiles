return {
	'https://github.com/nvim-telescope/telescope.nvim',
	branch = '0.1.x',
	opts = {
		defaults = { mappings = { i = { ['<C-u>'] = false, ['<C-d>'] = false } } }

	},
	config = function()
		require('telescope').load_extension('fzf')
		local builtin = require('telescope.builtin')
		Maps_keys({
			["n"] = {
				["<leader>ff"] = { builtin.live_grep, { desc = "Grep text" } },
				["<leader>fd"] = { builtin.find_files, { desc = "Find files" } },
				["<C-f>"] = { builtin.find_files, { desc = "Find files" } },
				["<leader>fb"] = { builtin.buffers, { desc = "[F]ind [B]uffer" } },
				["<leader>fh"] = { builtin.help_tags, { desc = "[F]ind [H]elp" } },

				["<leader><space>"] = { builtin.buffers, { desc = "Find Buffer" } },
				-- ["<leader>fd"] = { builtin.diagnostics, { desc = "Find Diagnostics" } },
				["<leader>fg"] = { builtin.git_files, { desc = "[F]ind [G]it files" } },
				--["<leader>"] = { builtin.oldfiles, { desc = "Find recently opened files" } },
				--["<leader>"] = { "<cmd> Telescope current_buffer_fuzzy_find <CR>", { desc = "Find in current buffer"} },

				["<leader>fm"] = { "<cmd> Telescope marks <CR>", { desc = "[F]ind [M]arks" } },

				-- git
				["<leader>gc"] = { "<cmd> Telescope git_commits <CR>", { desc = "[G]it [C]ommits" } },
				["<leader>gs"] = { "<cmd> Telescope git_status <CR>", { desc = "[G]it [S]tatus" } },

				["<leader>fs"] = { builtin.builtin, { desc = "[F]ind [S]elected" } },
				["<leader>fw"] = { builtin.grep_string, { desc = "search current word" } },
				["<leader>fr"] = { builtin.resume, { desc = "resume search" } }
			}
		})


		-- Custom live_grep function to search in git root
		local function live_grep_git_root()
			local git_root = Find_git_root()
			if git_root then
				require('telescope.builtin').live_grep {
					search_dirs = { git_root },
				}
			end
		end

		vim.api.nvim_create_user_command('LiveGrepGitRoot', live_grep_git_root, {})
	end,
	dependencies = {
		'https://github.com/nvim-lua/plenary.nvim',
		-- Fuzzy Finder Algorithm which requires local dependencies to be built.
		-- Only load if `make` is available. Make sure you have the system
		-- requirements installed.
		{
			'https://github.com/nvim-telescope/telescope-fzf-native.nvim',
			-- NOTE: If you are having trouble with this installation,
			--       refer to the README for telescope-fzf-native for more instructions.
			build = 'make',
			cond = function() return vim.fn.executable 'make' == 1 end
		}
	}
}
