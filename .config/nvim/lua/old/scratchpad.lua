

return {
	"https://github.com/metakirby5/codi.vim",
	enable = false,
	config = function()

		Maps_keys({
			["n"] = {
				["K"] = {"<cmd>CodiExpand<cr>",{desc="Scratchpad Debug expand"}}
			}
		})
	end,
}