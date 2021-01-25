Plugins = {
}

local packer = require("bootstrap") -- run setup in new envs
require("utils")                    -- load utils
require("options")                  -- set vim options

if (packer)
then
	Try_require('lazy').setup("plugins", {
		change_detection = {
			enabled = false,
			notify = false,
		},
		root = vim.fn.stdpath("config") .. "/.plugins/lazy",
		lockfile = vim.fn.stdpath("config") .. "/lazy-lock.json",
	})
end
Try_require("commands")    -- set commands
Try_require("mappings")    -- set mappings
Try_require("autocomands") -- set autocommands
