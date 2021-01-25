

local auto_format = false


local on_attach = function(Lsp, bufnr)


	vim.api.nvim_create_autocmd('BufWritePre', {
		buffer = bufnr,
		callback = function()
		  if not auto_format then
			return
		  end
		  vim.lsp.buf.format {
			async = false,
		  }
		end,
	  })

	Maps_keys({
		["n"] = {
			["<leader>rn"] = { vim.lsp.buf.rename, { desc = "[R]e[n]ame", buffer = bufnr } },
			["<leader>ca"] = { function()
				vim.lsp.buf.code_action(--[[{ context = { only = { 'quickfix', 'refactor', 'source' } } }]])
			end, { desc = "[C]ode [A]ction", buffer = bufnr } },
			["K"] = { vim.lsp.buf.hover, { desc = "Hover Documentation", buffer = bufnr } },
			["F"] = { vim.lsp.buf.format, { desc = "Format current buffer with LSP", buffer = bufnr } },
			["<C-k>"] = { vim.lsp.buf.signature_help, { desc = "Signature Documentation", buffer = bufnr } },
			["gD"] = { vim.lsp.buf.declaration, { desc = "[G]oto [D]eclaration", buffer = bufnr } },
			["<leader>wa"] = { vim.lsp.buf.add_workspace_folder, { desc = "[W]orkspace [A]dd Folder", buffer = bufnr } },
			["<leader>wr"] = { vim.lsp.buf.remove_workspace_folder, { desc = "[W]orkspace [R]emove Folder", buffer = bufnr } },
			["<leader>wl"] = { function()
				print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
			end, { desc = "[W]orkspace [L]ist Folders", buffer = bufnr } },
		},
	})

	-- Create a command `:Format` local to the LSP buffer
	vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
		vim.lsp.buf.format()
	end, { desc = 'Format current buffer with LSP' })

	if Check("telescope") then
		local telescope = require('telescope.builtin')
		Maps_keys({
			["n"] = {
				["gd"] = { telescope.lsp_definitions, { desc = "[G]oto [D]efinition", buffer = bufnr } },
				["gr"] = { telescope.lsp_references, { desc = "[G]oto [R]eferences", buffer = bufnr } },
				["gI"] = { telescope.lsp_implementations, { desc = "[G]oto [I]mplementation", buffer = bufnr } },
				["<leader>D"] = { telescope.lsp_type_definitions, { desc = "Type [D]efinition", buffer = bufnr } },
				["<leader>ds"] = { telescope.lsp_document_symbols, { desc = "[D]ocument [S]ymbols", buffer = bufnr } },
				["<leader>ws"] = { telescope.lsp_dynamic_workspace_symbols, { desc = "[W]orkspace [S]ymbols", buffer = bufnr } },
			},
		})
	end
end



return {
	'https://github.com/neovim/nvim-lspconfig',
	dependencies = {
		{ 'j-hui/fidget.nvim',   tag = 'legacy', event = "LspAttach", opts = {} },
		{ 'folke/neodev.nvim' },

		{ 'hrsh7th/nvim-cmp' },
		{ 'hrsh7th/cmp-nvim-lsp' },
		{ 'hrsh7th/cmp-buffer' },
		{ 'hrsh7th/cmp-path' },
		-- {'L3MON4D3/LuaSnip'},
		-- {'saadparwaiz1/cmp_luasnip'},
		-- {'rafamadriz/friendly-snippets'},
	},

	config = function()


		vim.api.nvim_create_user_command('AutoFormat', function()
			auto_format = not auto_format
			print('Setting autoformatting to: ' .. tostring(auto_format))
		end, {})


		local servers = Try_require("plugins/lsp/servers")

		require('neodev').setup({}) -- TODO

		local lsp = require("lspconfig")

		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

--[[
capabilities.textDocument.completion.completionItem = {
  documentationFormat = { "markdown", "plaintext" },
  snippetSupport = true,
  preselectSupport = true,
  insertReplaceSupport = true,
  labelDetailsSupport = true,
  deprecatedSupport = true,
  commitCharactersSupport = true,
  tagSupport = { valueSet = { 1 } },
  resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  },
}


]]--



		for name, settings in pairs(servers) do
			lsp[name].setup({
				capabilities = capabilities,
				on_attach = on_attach,
				settings,
				filetypes = (servers[server_name] or {}).filetypes,
			})
		end

		local cmp = require('cmp')

		cmp.setup({
			completion = {
				completeopt = 'menu,menuone,noinsert',
			},
			mapping = cmp.mapping.preset.insert {
				['<C-n>'] = cmp.mapping.select_next_item(),
				['<C-p>'] = cmp.mapping.select_prev_item(),
				['<C-Space>'] = cmp.mapping.complete {},
				['<CR>'] = cmp.mapping.confirm {
					behavior = cmp.ConfirmBehavior.Replace,
					select = true,
				},
				['<Tab>'] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					else
						fallback()
					end
				end, { 'i', 's' }),
				['<S-Tab>'] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					else
						fallback()
					end
				end, { 'i', 's' }),
			},
			sources = {
				{ name = 'nvim_lsp' },
				-- { name = 'luasnip' },
    { name = "buffer" },
				{ name = 'path' },
			},
		})
	end,
}
