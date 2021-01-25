vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	pattern = { "*" },
	callback = function()
		vim.cmd([[%s/\s\+$//ge]])
	end,
	desc = "Remove traling whitespaces"
})

-- dont list quickfix buffers
vim.api.nvim_create_autocmd("FileType", {
	pattern = "qf",
	callback = function()
	  vim.opt_local.buflisted = false
	end,
  })


vim.api.nvim_create_autocmd('TextYankPost', {
	callback = function() vim.highlight.on_yank() end,
	desc = "Highlight yanks",
	pattern = '*',
})


vim.api.nvim_create_autocmd("FileType", {
	pattern = { "gitcommit", "markdown" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
	end,
	desc = "wrap and check for spell in text filetypes"
})



vim.api.nvim_create_autocmd({ "VimLeave" }, {
	pattern = { "-" },
	callback = function()
		vim.cmd([[!xmodmap -e 'clear Lock' -e 'keycode 0x42 = Caps_Lock']])
	end,
	desc = "Enable caps Lock"
})

vim.api.nvim_create_autocmd({ "VimEnter" }, {
	pattern = { "-" },
	callback = function()
		vim.cmd([[!xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape']])
	end,
	desc = "Disable caps Lock"
})

vim.api.nvim_create_autocmd("BufReadPost", {
	callback = function()
		local exclude = { "gitcommit" }
		local buf = vim.api.nvim_get_current_buf()
		if vim.tbl_contains(exclude, vim.bo[buf].filetype) then
			return
		end
		local mark = vim.api.nvim_buf_get_mark(buf, '"')
		local lcount = vim.api.nvim_buf_line_count(buf)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
	desc = "go to last location when opening a buffer"
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = {
		"PlenaryTestPopup",
		"help",
		"lspinfo",
		"man",
		"notify",
		"qf",
		"spectre_panel",
		"startuptime",
		"tsplayground",
		"neotest-output",
		"checkhealth",
		"neotest-summary",
		"neotest-output-panel",
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
	end,
	desc = "close some filetypes with <q>"
})


local binarygroup = vim.api.nvim_create_augroup('binaryFiles', { clear = true })
vim.api.nvim_create_autocmd({ 'BufReadPre' }, {
	pattern = '*.bin',
	group = binarygroup,
	command = "let &bin=1",
})
vim.api.nvim_create_autocmd({ 'BufReadPost' }, {
	pattern = '*.bin',
	group = binarygroup,
	command = "if &bin | %!xxd",
})
vim.api.nvim_create_autocmd({ 'BufReadPost' }, {
	pattern = '*.bin',
	group = binarygroup,
	command = "set ft=xxd | endif",
})
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
	pattern = '*.bin',
	group = binarygroup,
	command = "if &bin | %!xxd -r",
})
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
	pattern = '*.bin',
	group = binarygroup,
	command = "endif",
})
vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
	pattern = '*.bin',
	group = binarygroup,
	command = "if &bin | %!xxd",
})
vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
	pattern = '*.bin',
	group = binarygroup,
	command = "set nomod | endif",
})
