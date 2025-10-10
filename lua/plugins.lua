-- ~/.config/nvim/lua/plugins.lua

return {
  -- Ваш менеджер плагинов
  "folke/lazy.nvim",

  -- *** ЦВЕТОВАЯ СХЕМА (Ваш стиль!) ***
  -- Это основа стиля. Выберите одну из сотен на https://vimcolorschemes.com/
  -- Вот несколько популярных современных вариантов:
{
  "catppuccin/nvim", -- Правильное название плагина на GitHub
  name = "catppuccin", -- Правильное внутреннее имя для lazy.nvim
  config = function()
    require("catppuccin").setup({ -- Настройка плагина
      flavour = "mocha", -- варианты: latte, frappe, macchiato, mocha
      transparent_background = false,
    })
    vim.cmd("colorscheme catppuccin") -- Правильное название схемы
  end,
},
  -- Или попробуйте другие:
  -- "ellisonleao/gruvbox.nvim",
  -- "navarasu/onedark.nvim",
  -- "rebelot/kanagawa.nvim",
  -- "catppuccin/nvim", name = "catppuccin",
  -- *** ТРИСИТТЕР (Treesitter) ***
  -- Обеспечивает подсветку синтаксиса, отступы и многое другое.
 
{
  'numToStr/Comment.nvim',
  config = function()
    require('Comment').setup({
      -- Дополнительные настройки (опционально)
      mappings = {
        basic = true,    -- Включить базовые mappingи
        extra = true,    -- Включить дополнительные mappingи
      }
    })
  end,
},

-- *** Автозакрывание скобок ***
{
  "windwp/nvim-autopairs",
  config = function()
    require("nvim-autopairs").setup({})
  end,
},

{
  "jiaoshijie/undotree",
  dependencies = { "nvim-lua/plenary.nvim" },
  ---@module 'undotree.collector'
  ---@type UndoTreeCollector.Opts
  opts = {
    -- your options
  },
  keys = { -- load the plugin only when using it's keybinding:
    { "<leader>u", "<cmd>lua require('undotree').toggle()<cr>" },
  },
},
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "lua", "vim", "vimdoc", "python", "bash", "javascript", "typescript", "cpp" },
        sync_install = false,
        auto_install = true,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
      })
    end,
  },

  -- *** ТЕЛЕСКОП (Telescope) ***
  -- Невероятно мощный fuzzy finder для навигации по файлам, grep, etc.
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.6",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
      vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
      vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
    end,
  },


  -- *** LSP и Autocompletion (Не обязательно, но ОЧЕНЬ рекомендуется) ***
  -- Это то, что делает NeoVim современной IDE.
  -- 1. Менеджер LSP серверов (для понимания кода)
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
      ensure_installed = { "clangd", "pyright", "pylsp" } -- Добавлены Python LSP серверы

      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")
      lspconfig.clangd.setup({}) -- Настройка LSP сервера для C/C++
    end,
  },

  -- *** Движок автодополнения ***
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp", -- LSP как источник дополнений
      "hrsh7th/cmp-buffer",   -- Дополнения из буфера
      "hrsh7th/cmp-path",     -- Дополнения путей файлов
      "L3MON4D3/LuaSnip",     -- Сниппеты
          "saadparwaiz1/cmp_luasnip", -- Добавьте этот плагин
    },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
                ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { "i", "s" }),
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" }, -- Основной источник - LSP
          { name = "luasnip" },  -- Сниппеты
        }, {
          { name = "buffer" },   -- Дополнения из текста в буфере
          { name = "path" },     -- Дополнения путей файлов
        })
      })
    end,
  },
}
