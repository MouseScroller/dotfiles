vim.g.mapleader = " " -- Leader Key
vim.g.maplocalleader = '<Ctrl>'

Assigne(vim, {
	opt = {
		hlsearch = true,                                    -- Set highlight on search
		shortmess = vim.opt.shortmess + { s = true, I = true }, -- disable startup message
		backspace = vim.opt.backspace + { "nostop" },       -- Don't stop backspace at insert
		clipboard = "unnamedplus",                          -- Connection to the system clipboard
		cmdheight = 1,                                      -- hide command line unless needed
		completeopt = { "menuone", "noselect" },            -- Options for insert mode completion
		copyindent = true,                                  -- Copy the previous indentation on autoindenting
		autoindent = true,                                  -- Autoindenting
		cursorline = true,                                  -- Highlight the text line of the cursor
		autoread = true,                                    -- auto reload files from disk
		colorcolumn = "110",                                -- marked column
		expandtab = false,                                  -- Enable the use of space in tab
		fileencoding = "utf-8",                             -- File content encoding for the buffer
		fillchars = { eob = " " },                          -- Disable `~` on nonexistent lines
		history = 100,                                      -- Number of commands to remember in a history table
		ignorecase = true,                                  -- Case insensitive searching
		smartcase = true,                                   -- Case sensitivie searching
		laststatus = 3,                                     -- globalstatus
		mouse = "nv",                                       -- mouse support in normal and visual mode
		number = true,                                      -- Show numberline
		preserveindent = true,                              -- Preserve indent structure as much as possible
		pumheight = 10,                                     -- Height of the pop up menu
		relativenumber = true,                              -- Show relative numberline
		scrolloff = 8,                                      -- Number of lines to keep above and below the cursor
		shiftwidth = 4,                                     -- Number of space inserted for indentation
		showmode = true,                                    -- Disable showing modes in command line
		showtabline = 2,                                    -- always display tabline
		sidescrolloff = 8,                                  -- Number of columns to keep at the sides of the cursor
		signcolumn = "yes",                                 -- Always show the sign column
		breakindent = true,                                 -- Enable break indent
		splitbelow = true,                                  -- Splitting a new window below the current one
		splitright = true,                                  -- Splitting a new window at the right of the current one
		tabstop = 4,                                        -- Number of space in a tab
		softtabstop = 0,
		termguicolors = true,                               -- Enable 24-bit RGB color in the TUI
		timeoutlen = 300,                                   -- Length of time to wait for a mapped sequence
		undofile = true,                                    -- Enable persistent undo
		updatetime = 300,                                   -- Length of time to wait before triggering the plugin
		wrap = false,                                       -- Disable wrapping of lines longer than the width of window
		writebackup = false,                                -- Disable making a backup before overwriting a file
		errorbells = false,                                 -- Disable Bell
		swapfile = false,                                   -- Disable swapfile
		wildignore = vim.opt.wildignore + { '*/node_modules/*', '*/.git/*' },
		matchpairs = { '(:)', '{:}', '[:]', '<:>' },
		list = true,
		listchars = {
			tab = '❘-',
			trail = '·',
			lead = '·',
			extends = '»',
			precedes = '«',
			nbsp = '×',
			eol = '↴',
			space = "⋅"
		}

	},
	g = {
		highlighturl_enabled = true,   -- highlight URLs by default
		zipPlugin = false,             -- disable zip
		load_black = false,            -- disable black
		loaded_2html_plugin = true,    -- disable 2html
		loaded_getscript = true,       -- disable getscript
		loaded_getscriptPlugin = true, -- disable getscript
		loaded_gzip = true,            -- disable gzip
		loaded_logipat = true,         -- disable logipat
		loaded_matchit = true,         -- disable matchit
		loaded_netrw = true,           -- disable netrw
		loaded_netrwFileHandlers = true, -- disable netrw
		loaded_netrwPlugin = true,     -- disable netrw
		loaded_netrwSettngs = true,    -- disable netrw
		loaded_remote_plugins = true,  -- disable remote plugins
		loaded_tar = true,             -- disable tar
		loaded_tarPlugin = true,       -- disable tar
		loaded_zip = true,             -- disable zip
		loaded_zipPlugin = true,       -- disable zip
		loaded_vimball = true,         -- disable vimball
		loaded_vimballPlugin = true,   -- disable vimball
		autoformat_enabled = true,     -- enable or disable auto formatting at start (lsp.formatting.format_on_save must be enabled)
		lsp_handlers_enabled = true,   -- enable or disable default vim.lsp.handlers (hover and signatureHelp)
		cmp_enabled = true,            -- enable completion at start
		autopairs_enabled = true,      -- enable autopairs at start
		diagnostics_enabled = true,    -- enable diagnostics at start
		status_diagnostics_enabled = true, -- enable diagnostics in statusline
		icons_enabled = true,          -- disable icons in the UI (disable if no nerd font is available)
		ui_notifications_enabled = true, -- disable notifications when toggling UI elements
		heirline_bufferline = false,   -- enable heirline bufferline (TODO v3: remove this option and make it default)
	},
})
