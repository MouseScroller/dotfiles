
-- TODO
package.key_maps = function()
	Maps_keys({
		["n"] = {
			["<A-t>"] = {"<cmd>ToggleTerm direction=float<cr>",{desc="Open terminal"}}
		}

	})
end



return {
	"https://github.com/akinsho/toggleterm.nvim",
	enabled = false,

}