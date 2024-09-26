local actions = {}

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

-- add treesitter parser folder
local parser = vim.fn.stdpath("config") .. "/.plugins/parsers"
vim.opt.rtp:append(parser)
return {
  { import = "lazyvim.plugins.extras.editor.aerial" },
  { import = "lazyvim.plugins.extras.editor.illuminate" },
  { import = "lazyvim.plugins.extras.editor.leap" },
  { import = "lazyvim.plugins.extras.lang.clangd" },
  { import = "lazyvim.plugins.extras.lang.docker" },
  { import = "lazyvim.plugins.extras.lang.git" },
  { import = "lazyvim.plugins.extras.lang.json" },
  { import = "lazyvim.plugins.extras.lang.markdown" },
  { import = "lazyvim.plugins.extras.lang.rust" },
  { import = "lazyvim.plugins.extras.lang.sql" },
  { import = "lazyvim.plugins.extras.lsp.none-ls" },
  { import = "lazyvim.plugins.extras.ui.mini-starter" },
  { import = "lazyvim.plugins.extras.util.dot" },
  -- add gruvbox
  { "ellisonleao/gruvbox.nvim" },

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
    },
  },

  -- Configure LazyVim to load gruvbox
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      close_if_last_window = true,
      filesystem = {
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = false,
          never_show_by_pattern = {
            "node_modules",
            ".git",
            ".github",
            "target",
          },
        },
      },
    },
  },
  {
    "echasnovski/mini.hipatterns",
    config = function()
      local hipatterns = require("mini.hipatterns")
      hipatterns.setup({
        highlighters = {
          -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
          fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
          hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
          todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
          note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },

          -- Highlight hex color strings (`#rrggbb`) using that color #AAAAAA
          hex_color = hipatterns.gen_highlighter.hex_color(),
        },
      })
    end,
  },
  {
    "echasnovski/mini.starter",
    config = function(_, config)
      local starter = require("mini.starter")

      table.insert(actions, { action = ":ene <BAR> startinsert ", name = "New file", section = "Actions" })

      table.insert(actions, { action = ":Telescope find_files", name = "Find file", section = "Actions" })
      table.insert(actions, { action = ":Telescope live_grep", name = "Find in file", section = "Actions" })
      table.insert(actions, { action = ":Telescope oldfiles", name = "Recent files", section = "Actions" })

      table.insert(actions, { action = ":cd ~/.config/nvim | e . ", name = "Nvim Settings", section = "Actions" })
      table.insert(actions, { action = ":cd ~/.config/bash | e . ", name = "Bash Settings", section = "Actions" })
      table.insert(actions, { action = ":qa", name = "Quit NVIM", section = "Actions" })

      -- Projects are in home/user/dev
      local projects = Split(vim.fn.glob("~/dev/*"), "\n")

      for _, str in pairs(projects) do
        for s in string.gmatch(str, "/([a-zA-Z_-]+)$") do
          str = s
          break
        end

        table.insert(actions, { action = ":cd ~/dev/" .. str .. " | e .", name = str .. " open", section = "Projects" })
      end

      config.items = actions

      if vim.o.filetype == "lazy" then
        vim.cmd.close()
        vim.api.nvim_create_autocmd("User", {
          pattern = "MiniStarterOpened",
          callback = function()
            require("lazy").show()
          end,
        })
      end
      starter.setup(config)

      vim.api.nvim_create_autocmd("User", {
        pattern = "LazyVimStarted",
        callback = function()
          local stats = require("lazy").stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          local pad_footer = string.rep(" ", 8)
          starter.config.footer = pad_footer .. "⚡ Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
          pcall(starter.refresh)
        end,
      })
    end,

    opts = {
      autoopen = true,
      evaluate_single = false,
      items = actions,
      footer = nil,
      header = [[
  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
                                                       ]],

      -- Array  of functions to be applied consecutively to initial content.
      -- Each function should take and return content for 'Starter' buffer (see
      -- |mini.starter| and |MiniStarter.content| for more details).
      content_hooks = nil,
      query_updaters = "abcdefghijklmnopqrstuvwxyz0123456789_-.",

      -- Whether to disable showing non-error feedback
      silent = false,
    },
  },
  -- add more treesitter parsers
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      parser_install_dir = vim.fn.stdpath("config") .. "/.plugins/parsers",
      auto_install = true,

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
        -- "html_tags",
        "javascript",
        "jq",
        "lua",
        "make",
        "markdown",
        "markdown_inline",
        "query",
        "rust",
        "regex",
        "sql",
        "toml",
        "typescript",
        "vim",
        "vimdoc",
      },
    },
  },
}
