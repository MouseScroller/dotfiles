return {
	enable = false,
	"https://github.com/lewis6991/gitsigns.nvim",
	opts = {
		numhl = true,
		current_line_blame = true,
		signs = {
			add = { text = '+' },
			change = { text = '~' },
			delete = { text = '_' },
			topdelete = { text = '‾' },
			changedelete = { text = '~' },
			untracked = { text = "?" },
		},

		on_attach = function(bufnr)
			local gs = package.loaded.gitsigns

			Maps_keys({
				["n"] = {
					["<leader>gb"] = { gs.blame_line({ full = false }), { desc = "[G]it [B]lame line", buffer = bufnr } },
					["<leader>gd"] = { gs.toggle_deleted, { desc = "[G]it [D]eleted", buffer = bufnr } },
					["<leader>gc"] = { "<cmd>Gitsigns toggle_word_diff<cr>", { desc = "[G]it [C]hanges", buffer = bufnr } },
					["<leader>ga"] = { gs.stage_buffer, { desc = "[G]it [A]dd buffer", buffer = bufnr } },
					["<leader>gr"] = { gs.reset_buffer, { desc = "[G]it [R]eset buffer", buffer = bufnr } },

					["<leader>gh"] = { gs.next_hunk(), { desc = "[G]it next [H]unk", buffer = bufnr } },
					["<leader>gH"] = { gs.prev_hunk(), { desc = "[G]it previous [H]unk", buffer = bufnr } },

					["<leader>gha"] = { gs.stage_hunk, { desc = "[G]it [H]unk [A]dd", buffer = bufnr } },
					["<leader>ghr"] = { gs.reset_hunk, { desc = "[G]it [H]unk [R]eset", buffer = bufnr } },
					["<leader>gp"] = { gs.preview_hunk, { desc = "[G]it [P]review hunk", buffer = bufnr } },
					["<leader>gi"] = { gs.diffthis, { desc = "[G]it diff against [I]ndex", buffer = bufnr } },
					
					["<leader>gl"] = { function()
						gs.diffthis('~')
					end, { desc = "[G]it diff against [L]ast commit", buffer = bufnr } },

					["<leader>gu"] = { gs.undo_stage_hunk, { desc = "[G]it [U]ndo stage hunk", buffer = bufnr } },

				},
				["v"] = {
					["<leader>gh"] = { gs.next_hunk(), { desc = "[G]it next [H]unk", buffer = bufnr } },
					["<leader>gH"] = { gs.prev_hunk(), { desc = "[G]it previous [H]unk", buffer = bufnr } },

					["<leader>gha"] = { gs.stage_hunk({ vim.fn.line '.', vim.fn.line 'v' }), { desc = "[G]it [H]unk [A]dd", buffer = bufnr } },
					["<leader>ghr"] = { gs.reset_hunk({ vim.fn.line '.', vim.fn.line 'v' }), { desc = "[G]it [H]unk [R]eset", buffer = bufnr } },
				}
			})
		end
	},
	config = function()
	end,
}
