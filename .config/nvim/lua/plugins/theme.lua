return {
	"https://github.com/ellisonleao/gruvbox.nvim",
	priority = 1000,
	config = function()
		vim.o.background = "dark"
		vim.cmd.colorscheme 'gruvbox'
	end,
	opts = {
		italic = {
			strings = false,
			operators = false,
			comments = true
		},
		contrast = "hard",
		transparent_mode = true,
	},
}
