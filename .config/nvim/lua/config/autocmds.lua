-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*" },
  callback = function()
    vim.cmd([[%s/\s\+$//ge]])
  end,
  desc = "Remove traling whitespaces",
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
  desc = "wrap and check for spell in text filetypes",
})

vim.api.nvim_create_autocmd({ "VimLeave" }, {
  pattern = { "-" },
  callback = function()
    vim.cmd([[!xmodmap -e 'clear Lock' -e 'keycode 0x42 = Caps_Lock']])
  end,
  desc = "Enable caps Lock",
})

vim.api.nvim_create_autocmd({ "VimEnter" }, {
  pattern = { "-" },
  callback = function()
    vim.cmd([[!xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape']])
  end,
  desc = "Disable caps Lock",
})

local binarygroup = vim.api.nvim_create_augroup("binaryFiles", { clear = true })
vim.api.nvim_create_autocmd({ "BufReadPre" }, {
  pattern = "*.bin",
  group = binarygroup,
  command = "let &bin=1",
})
vim.api.nvim_create_autocmd({ "BufReadPost" }, {
  pattern = "*.bin",
  group = binarygroup,
  command = "if &bin | %!xxd",
})
vim.api.nvim_create_autocmd({ "BufReadPost" }, {
  pattern = "*.bin",
  group = binarygroup,
  command = "set ft=xxd | endif",
})
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = "*.bin",
  group = binarygroup,
  command = "if &bin | %!xxd -r",
})
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = "*.bin",
  group = binarygroup,
  command = "endif",
})
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  pattern = "*.bin",
  group = binarygroup,
  command = "if &bin | %!xxd",
})
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  pattern = "*.bin",
  group = binarygroup,
  command = "set nomod | endif",
})
