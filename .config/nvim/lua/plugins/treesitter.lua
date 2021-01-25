return {
	"https://github.com/nvim-treesitter/nvim-treesitter",
	dependencies = {
		'nvim-treesitter/nvim-treesitter-textobjects',
	},
	config = function(_, opts)
		local parsers = vim.fn.stdpath("config") .. "/.plugins/parsers"
		vim.opt.rtp:prepend(parsers)


		opts.parser_install_dir = parsers
	end,
	build = ':TSUpdate',
	opts = {
		auto_install = true,
		ignore_install = { "" },
		sync_install = false,
		indent = { enable = true },
		modules = {},
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = '<c-space>',
				node_incremental = '<c-space>',
				scope_incremental = '<c-s>',
				node_decremental = '<M-space>',
			},
		},
		textobjects = {
			select = {
				enable = true,
				lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
				keymaps = {
					-- You can use the capture groups defined in textobjects.scm
					['aa'] = '@parameter.outer',
					['ia'] = '@parameter.inner',
					['af'] = '@function.outer',
					['if'] = '@function.inner',
					['ac'] = '@class.outer',
					['ic'] = '@class.inner',
				},
			},
			move = {
				enable = true,
				set_jumps = true, -- whether to set jumps in the jumplist
				goto_next_start = {
					[']m'] = '@function.outer',
					[']]'] = '@class.outer',
				},
				goto_next_end = {
					[']M'] = '@function.outer',
					[']['] = '@class.outer',
				},
				goto_previous_start = {
					['[m'] = '@function.outer',
					['[['] = '@class.outer',
				},
				goto_previous_end = {
					['[M'] = '@function.outer',
					['[]'] = '@class.outer',
				},
			},
			swap = {
				enable = true,
				swap_next = {
					['<leader>a'] = '@parameter.inner',
				},
				swap_previous = {
					['<leader>A'] = '@parameter.inner',
				},
			},
		},
		ensure_installed = {
			"awk",
			"bash",
			"c",
			"comment",
			"cpp",
			"css",
			"diff",
			"git_config",
			"git_rebase",
			"gitattributes",
			"gitcommit",
			"gitignore",
			"hjson",
			"html",
			--"html_tags",
			"javascript",
			"jq",
			"lua",
			"make",
			"markdown",
			"markdown_inline",
			"rust",
			"regex",
			"sql",
			"toml",
			"typescript",
			"vim",
			"vimdoc",
			"query",
		},
		highlight = {
			enable = true,
			additional_vim_regex_highlighting = false,
			use_languagetree = true, -- TODO
		}
	}
}
