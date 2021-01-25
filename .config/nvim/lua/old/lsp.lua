local package = {
    enable = false,
    url = "https://github.com/neovim/nvim-lspconfig"
}

package.key_maps = function(bufnr)

    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = {noremap = true, silent = false, buffer = bufnr}
    -- vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', '<space>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set('n', '<leader>f',
                   function() vim.lsp.buf.format {async = true} end, bufopts)

    Maps_keys({
        ["n"] = {
            ["gD"] = {
                vim.lsp.buf.declaration,
                Assigne(bufopts, {desc = "Go to declaration"})
            },
            ["K"] = {
                vim.lsp.buf.hover, Assigne(bufopts, {desc = "Show Information"})
            },
            ["gi"] = {
                vim.lsp.buf.implementation,
                Assigne(bufopts, {desc = "Go to implementation"})
            },
            ["<C-k>"] = {
                vim.lsp.buf.signature_help,
                Assigne(bufopts, {desc = "Show signature help"})
            },
            ["<leader>wa"] = {
                vim.lsp.buf.add_workspace_folder,
                Assigne(bufopts, {desc = "add workspace folder"})
            },
            ["<leader>wr"] = {
                vim.lsp.buf.remove_workspace_folder,
                Assigne(bufopts, {desc = "remove workspace folder"})
            },
            ["<leader>D"] = {
                vim.lsp.buf.type_definition,
                Assigne(bufopts, {desc = "Show type definition"})
            },
            ["<leader>rn"] = {
                vim.lsp.buf.rename, Assigne(bufopts, {desc = "Rename symbole"})
            },
            ["<leader>ca"] = {
                vim.lsp.buf.code_action,
                Assigne(bufopts, {desc = "Code action"})
            },
            ["gr"] = {
                vim.lsp.buf.references,
                Assigne(bufopts, {desc = "Open references"})
            }
        }
    })

    vim.api.nvim_create_user_command("F", function()
        vim.lsp.buf.format({async = false})
    end, {})
end

package.setup = function()

    local capabilities = require('cmp_nvim_lsp').default_capabilities()
    local lsp = require("lspconfig")
    local cmp = require("cmp")

    cmp.setup({
        snippet = {
            expand = function(args)
                require'luasnip'.lsp_expand(args.body)
            end
        },
        mapping = cmp.mapping.preset.insert({
            ['<C-d>'] = cmp.mapping.scroll_docs(-4),
            ['<C-c>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-x>'] = cmp.mapping.abort(),
            ['<CR>'] = cmp.mapping.confirm({select = true}) -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        }),
        sources = {
            {name = 'nvim_lsp'}, {name = 'buffer'}, {name = 'path'},
            {name = 'luasnip'}
        }
    })

    vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(ev) package.key_maps(ev.buf) end
    })

    -- Lua
    lsp.lua_ls.setup {
        settings = {
            Lua = {
                telemetry = {enable = false},
                diagnostics = {
                    -- Get the language server to recognize the `vim` global
                    globals = {'vim'}
                },
                workspace = {
                    checkThirdParty = false,
                    -- Make the server aware of Neovim runtime files
                    library = vim.api.nvim_get_runtime_file("", true)
                }
            }
        },
        capabilities = capabilities
    }

    -- Rust
    lsp.rust_analyzer.setup {capabilities = capabilities}

    -- Bash
    lsp.bashls.setup {
        settings = {bashIde = {includeAllWorkspaceSymbols = true}},
        capabilities = capabilities
    }

    -- c/c++
    lsp.clangd.setup {capabilities = capabilities}

    -- json
    lsp.jsonls.setup {capabilities = capabilities}

    -- SQL
    lsp.sqlls.setup {capabilities = capabilities}

    -- js/ts
    lsp.tsserver.setup {capabilities = capabilities}

end

package.init = function()
    return {
        Split_package(package), {'hrsh7th/nvim-cmp'}, {'hrsh7th/cmp-nvim-lsp'},
        {'hrsh7th/cmp-buffer'}, {'hrsh7th/cmp-path'}, {'folke/neodev.nvim'},
        {"j-hui/fidget.nvim", tag = "legacy", event = "LspAttach"},
        {'L3MON4D3/LuaSnip'}, {'saadparwaiz1/cmp_luasnip'},
        {'rafamadriz/friendly-snippets'}
    }
end

return package.init()
