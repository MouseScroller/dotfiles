local package = {
    enable = false,
	url = "https://github.com/iamcco/markdown-preview.nvim",
}


package.key_maps = function()
	Maps_keys({
		["n"] = {
			["<leader>op"] = {"<cmd>MarkdownPreview<cr>",{desc="Toggle Markdown preview"}}
		}

	})
end

package.setup = function()
	
	vim.g.mkdp_auto_close = false;
	vim.g.mkdp_open_to_the_world = true;

	package.key_maps()

end

package.init = function()
	return Split_package(package)
end

return package.init()