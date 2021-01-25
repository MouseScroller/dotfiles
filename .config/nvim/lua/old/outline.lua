local package = {
    enable = false,
	url = "https://github.com/simrat39/symbols-outline.nvim",
}


package.key_maps = function()
	Maps_keys({
		["n"] = {
			["<leader>o"] = {
				function()
					vim.cmd([[SymbolsOutline]])
				end,
				{ desc = "Toggle outliner" } },
		}
	})
end

package.setup = function()
	
    require("symbols-outline").setup()


	vim.api.nvim_create_user_command("Outline", function()
		vim.cmd([[SymbolsOutline]])
	end, {})
	package.key_maps()

end

package.init = function()
	return Split_package(package)
end

return package.init()