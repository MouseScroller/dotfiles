Mappings = {
	i = {}, -- Insert
	n = {
		["s"] = "Forward search",
		["S"] = "Backward search",
		["gs"] = "Global forward search",
		["gS"] = "Global backward search",
	},   -- Normal
	v = {}, -- Visual and Select
	t = {}, -- Terminal
	x = {}, -- Visual
	c = {}, -- Commandline
	o = {}, -- Operator pending
}

--[[
register key maps from an object
{
	mode = {
		keys=action | action , { buffer,nowait,silent,script,expr,unique }
	}
}
--]]
function Maps_keys(obj)
	for mode, t in pairs(obj) do
		for keys, v in pairs(t) do
			if (keys ~= "")
			then
				if (type(v[2]) == "table")
				then
					Mappings[mode][keys] = v[2].desc
					vim.keymap.set(mode, keys, v[1], v[2])
				else
					Mappings[mode][keys] = v
					vim.keymap.set(mode, keys, v)
				end
			end
		end
	end
	-- Log(Mappings)
end

-- deep merge objects
function Assigne(obj1, obj2)
	for k, v in pairs(obj2) do
		if (type(obj1[k]) == "table" and type(v) == "table")
		then
			Assigne(obj1[k], v)
		else
			obj1[k] = v
		end
	end
	return obj1
end

-- requires the file or prints an error
function Try_require(path)
	local status_ok, response = pcall(require, path)

	if not status_ok
	then
		vim.api.nvim_err_writeln("Error in [" .. path .. "]\n\n" .. response)
	else
		return response
	end
	return nil
end

-- Split a string into a table
function Split(inputstr, sep)
	if sep == nil then
		sep = "%s"
	end
	local t = {}
	for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
		table.insert(t, str)
	end
	return t
end

function Check(package)
	if package.loaded and package.loaded[package]
	then
		return true
	end
	return false
end

function Log(data)
	log = ToString(data)

	if false and Check("notify") then
		vim.notify(log)
	else
		-- vim.api.nvim_err_writeln(log)
		print(log)
	end
end

function ToString(o)
	if type(o) == 'table' then
		local s = '{ '
		for k, v in pairs(o) do
			if type(k) ~= 'number' then k = '"' .. k .. '"' end
			s = s .. '[' .. k .. '] = ' .. ToString(v) .. ','
		end
		return s .. '} '
	else
		return "'" .. tostring(o) .. "'"
	end
end

function Find_git_root()
	-- Use the current buffer's path as the starting point for the git search
	local current_file = vim.api.nvim_buf_get_name(0)
	local current_dir
	local cwd = vim.fn.getcwd()
	-- If the buffer is not associated with a file, return nil
	if current_file == '' then
		current_dir = cwd
	else
		-- Extract the directory from the current file's path
		current_dir = vim.fn.fnamemodify(current_file, ':h')
	end

	-- Find the Git root directory from the current file's path
	local git_root = vim.fn.systemlist('git -C ' .. vim.fn.escape(current_dir, ' ') .. ' rev-parse --show-toplevel')[1]
	if vim.v.shell_error ~= 0 then
		print 'Not a git repository. Searching on current working directory'
		return cwd
	end
	return git_root
end

