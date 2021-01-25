local package = {
    enable = false,
	url = "https://github.com/ggandor/leap.nvim",
}


package.key_maps = function()
	Maps_keys({
		["mode"] = {
			[""] = {"",{desc="description"}}
		}
	})
end

package.setup = function()
	Try_require("leap").add_default_mappings()
	package.key_maps()

end

package.init = function()
	return Split_package(package)
end

return package.init()