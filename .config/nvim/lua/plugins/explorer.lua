return {
	"https://github.com/nvim-tree/nvim-tree.lua",
	config = function()
		require("nvim-tree").setup({
			sort = {
				sorter = "case_sensitive",
			},
			view = {
				width = 30,
			},
			renderer = {
				group_empty = true,
			},
			filters = {
				dotfiles = true,
			},
		})
		Maps_keys({
			["n"] = {
				["<leader>b"] = { "<cmd>NvimTreeFindFileToggle<cr>", { desc = "Goto Explorer" } }
			}
		})
	end
}
