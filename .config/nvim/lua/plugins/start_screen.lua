local actions = {
}


table.insert(actions, { action = ":ene <BAR> startinsert ", name = "New file", section = "Actions" })
--if Check("telescope") -- TODO make optional
--then
table.insert(actions, { action = ":Telescope find_files", name = "Find file", section = "Actions" })
table.insert(actions, { action = ":Telescope live_grep", name = "Find in file", section = "Actions" })
table.insert(actions, { action = ":Telescope oldfiles", name = "Recent files", section = "Actions" })
--end
if Check("codi")
then
	table.insert(actions, { action = ":CodiNew ", name = "Scratchpad open", section = "Actions" })
end
table.insert(actions, { action = ":cd ~/.config/nvim | e . ", name = "Nvim Settings", section = "Actions" })
table.insert(actions, { action = ":cd ~/.config/bash | e . ", name = "Bash Settings", section = "Actions" })
table.insert(actions, { action = ":qa", name = "Quit NVIM", section = "Actions" })

-- Projects are in home/user/dev
local projects = Split(vim.fn.glob("~/dev/*"), "\n");

for i, str in pairs(projects) do
	for s in string.gmatch(str, "/([a-zA-Z_-]+)$") do
		str = s
		break
	end

	table.insert(actions, { action = ":cd ~/dev/" .. str .. " | e .", name = str .. " open", section = "Projects" })
end


return {
	'https://github.com/echasnovski/mini.starter',
	version = '*',
	opts = {
		autoopen = true,
		evaluate_single = false,
		items = actions,

		footer = nil,
		header = [[
  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
                                                       ]],

		-- Array  of functions to be applied consecutively to initial content.
		-- Each function should take and return content for 'Starter' buffer (see
		-- |mini.starter| and |MiniStarter.content| for more details).
		content_hooks = nil,
		query_updaters = 'abcdefghijklmnopqrstuvwxyz0123456789_-.',

		-- Whether to disable showing non-error feedback
		silent = false,
	}
}
