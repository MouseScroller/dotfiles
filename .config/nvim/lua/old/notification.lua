local package = {
    enable = false,
	url = "https://github.com/rcarriga/nvim-notify",
}


package.key_maps = function()
	
    
    if (Plugins["telescope"])
	then
		Maps_keys({["m"]={
			["<leader>n"] = {
				require('telescope').extensions.notify.notify()
			}
		}})
	end
end

package.setup = function()
	
	require("notify").setup({
		background_colour = "#000000",
	})
    package.key_maps()
end

package.init = function()
	return Split_package(package)
end

return package.init()