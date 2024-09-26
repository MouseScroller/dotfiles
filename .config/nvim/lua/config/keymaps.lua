-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

function Maps_keys(obj)
  for mode, t in pairs(obj) do
    for keys, v in pairs(t) do
      if (keys ~= "")
      then
        if (type(v[2]) == "table")
        then
          vim.keymap.set(mode, keys, v[1], v[2])
        else
          vim.keymap.set(mode, keys, v)
        end
      end
    end
  end
end

vim.cmd([[:command WQ wq]])
vim.cmd([[:command Wq wq]])
vim.cmd([[:command W w]])
vim.cmd([[:command Q q]])

Maps_keys({
  ["n"] = {
    ["<F5>"] = { "<cmd>!builder build run<cr>", { desc = "build and run" } },
    ["<F6>"] = { "<cmd>!builder build<cr>", { desc = "build" } },
    ["<F7>"] = { "<cmd>!builder run<cr>", { desc = "run" } },
  },
  ["i"] = {
  },
  ["t"] = {
    ["<Esc>"] = { "<C-\\><C-n>", { desc = "Esc exits terminal mod" } },
    ["<C-x>"] = { vim.api.nvim_replace_termcodes("<C-\\><C-N>", true, true, true), { desc = "Escape terminal mode" } },
  },
  ["v"] = {
    ["<Space>"] = { "<Nop>", { silent = true } },
    -- Indenting
    ["<"] = { "<gv", { desc = "incresse Indenting" } },
    [">"] = { ">gv", { desc = "decresse Indenting" } },
  }
})
