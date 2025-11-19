return {
  -- Ваш менеджер плагинов
  "folke/lazy.nvim",

  -- *** ЦВЕТОВАЯ СХЕМА ***
  {
    "iruzo/matrix-nvim",
    priority = 1000,
    config = function()
      vim.g.matrix_transparent = false
      vim.g.matrix_bold = true
      vim.g.matrix_italic = true
      vim.g.matrix_underline = true
      vim.cmd("colorscheme matrix")
    end,
  },

  -- *** ТРИСИТТЕР (Treesitter) ***
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

  -- *** Комментарии ***
  {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup({
        mappings = {
          basic = true,
          extra = true,
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

  -- *** Undo history ***
  {
    "debugloop/telescope-undo.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      require("telescope").load_extension("undo")
    end,
    keys = {
      { "<leader>u", "<cmd>Telescope undo<CR>", desc = "Undo history" },
    },
    event = "VeryLazy",
  },

  -- *** ТЕЛЕСКОП (Telescope) ***
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

  -- *** LSP и Autocompletion ***
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
        ensure_installed = { "clangd", "pyright", "pylsp", "lua_ls" }
      })
    end,
  },

  -- 2. LSP конфигурация (ИСПРАВЛЕННАЯ ВЕРСИЯ)
{
  "neovim/nvim-lspconfig",
  dependencies = {
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp"
  },
  config = function()
    local capabilities = require('cmp_nvim_lsp').default_capabilities()
    local lspconfig = require('lspconfig') -- ДОБАВЬТЕ ЭТУ СТРОКУ

    -- ИСПРАВЛЕННАЯ конфигурация clangd для Qt6
    lspconfig.clangd.setup({  -- ИСПРАВЛЕНО: используйте lspconfig.clangd.setup
      capabilities = capabilities,
      cmd = {
        "clangd",
        "--background-index",
        "--compile-commands-dir=build",
        "--query-driver=/usr/bin/g++",
        "--header-insertion=never",
        "--all-scopes-completion",
        "--completion-style=detailed",
      },
      filetypes = {"c", "cpp", "objc", "objcpp"},
      init_options = {
        clangdFileStatus = true,
        usePlaceholders = true,
        completeUnimported = true,
        clangTidy = true,
      }
    })

    -- Остальные LSP серверы...
    lspconfig.pyright.setup({  -- ИСПРАВЛЕНО
      capabilities = capabilities,
    })

    lspconfig.pylsp.setup({  -- ИСПРАВЛЕНО
      capabilities = capabilities,
    })

    lspconfig.lua_ls.setup({  -- ИСПРАВЛЕНО
      capabilities = capabilities,
      settings = {
        Lua = {
          runtime = { version = 'LuaJIT' },
          diagnostics = { globals = {'vim'} },
          workspace = { 
            library = vim.api.nvim_get_runtime_file("", true),
            checkThirdParty = false
          },
          telemetry = { enable = false },
        }
      }
    })

    -- УДАЛИТЕ эти строки - они больше не нужны:
    -- vim.lsp.enable('clangd')
    -- vim.lsp.enable('pyright')
    -- vim.lsp.enable('pylsp')
    -- vim.lsp.enable('lua_ls')

    -- Ключевые mappingи для LSP
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = 'Go to declaration' })
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to definition' })
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'Hover documentation' })
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { desc = 'Go to implementation' })
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, { desc = 'Signature help' })
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = 'Rename symbol' })
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'Code action' })
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, { desc = 'References' })
  end,
},

  -- 3. Autocompletion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer", 
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
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

          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
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
          { name = "nvim_lsp" },
          { name = "luasnip" },
        }, {
          { name = "buffer" },
          { name = "path" },
        })
      })
    end,
  },
}
