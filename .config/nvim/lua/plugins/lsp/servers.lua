return {
	lua_ls = {
		Lua = {
			workspace = {
				checkThirdParty = false,
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true)
			},
			telemetry = { enable = false },
			-- NOTE: toggle below to ignore Lua_LS's noisy `missing-fields` warnings
			-- diagnostics = { disable = { 'missing-fields' } },
		},
	},
	rust_analyzer = { -- Rust
		settings = {
		},
	},
	bashls = { settings = { bashIde = { includeAllWorkspaceSymbols = true } } }, -- Bash
	clangd = {
		settings = {
		},
	}, -- c/c++
	jsonls = {
		settings = {},
	}, -- json
	sqlls = {
		settings = {},
	}, -- SQL
	tsserver = {
		settings = {},
	} -- js/ts
}
