local update_everything = function()
	vim.cmd([[:Lazy sync]])
	vim.cmd([[:TSUpdateSync]])
end
local ensure_packer = function()
	local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
	-- local install_path = vim.fn.stdpath('config')..'/plugin/start/packer.nvim'
	vim.opt.rtp:prepend(install_path)
	if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
		vim.fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
		vim.cmd [[packadd packer.nvim]]
		return true
	end
	-- vim.cmd [[packadd packer.nvim]]
	return true
end

local ensure_lazy = function()
	local lazypath = vim.fn.stdpath("config") .. "/.plugins/lazy/lazy.nvim"

	if not vim.loop.fs_stat(lazypath) then
		vim.fn.system({
			"git",
			"clone",
			"--filter=blob:none",
			"https://github.com/folke/lazy.nvim.git",
			"--branch=stable", -- latest stable release
			lazypath,
		})
	end
	vim.opt.rtp:prepend(lazypath)
	return true
end

local bootstrap = function()
	vim.api.nvim_create_user_command("Update", function()
		update_everything();
	end, {})

	return ensure_lazy()
end



return bootstrap()
