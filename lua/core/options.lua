-- ~/.config/nvim/lua/core/options.lua

vim.opt.number = true      
vim.opt.relativenumber = true -- Включает относительную нумерацию строк (очень полезно для навигации)

vim.opt.mouse = "a"          -- Включить мышь во всех режимах
vim.opt.ignorecase = true    -- Игнорировать регистр при поиске
vim.opt.smartcase = true     -- Не игнорировать регистр, если есть заглавные буквы
vim.opt.hlsearch = true      -- Подсвечивать результаты поиска
vim.opt.wrap = false         -- Не переносить строки
vim.opt.breakindent = true   -- Сохранять отступ при переносе строк (если wrap включен)
vim.opt.tabstop = 4          -- Количество пробелов, которые вставляются при нажатии Tab
vim.opt.shiftwidth = 4       -- Размер отступа для операций >>, <<, ==
vim.opt.expandtab = true     -- Преобразовать Tab в пробелы
vim.opt.scrolloff = 10

-- Mapping для добавления пустых строк
vim.keymap.set('n', '<leader>bb', '<cmd>lua AddBlankLinesAtEnd(10)<CR>', { desc = 'Add 10 blank lines at end' })
-- Включить 24-битные цвета (для лучшей цветовой схемы)
vim.opt.termguicolors = true
-- Перенос длинных строк
vim.opt.wrap = true          -- Включить перенос строк
vim.opt.linebreak = true     -- Переносить по словам, а не по символам
vim.opt.breakindent = true   -- Сохранять отступ при переносе
vim.opt.showbreak = "↪ "     -- Символ для обозначения перенесенной строки
-- Стиль и внешний вид (часть "своего стиля")
vim.opt.cursorline = true    -- Подсвечивать текущую строку
-- vim.opt.signcolumn = "yes"   -- Всегда показывать колонку с знаками (для диагностики и т.д.)
-- Настройки диагностики LSP
vim.diagnostic.config({
  virtual_text = {
    source = "if_many",  -- Показывать источник ошибки (например, clangd)
    prefix = "●",        -- Префикс для ошибок
    -- Форматирование текста ошибки
    format = function(diagnostic)
      return string.format("%s (%s)", diagnostic.message, diagnostic.source)
    end,
  },
  signs = true,          -- Показывать значки на полях
  underline = true,      -- Подчеркивать ошибки
  update_in_insert = false,
  severity_sort = true,
})

-- Цвета для виртуального текста
vim.cmd([[
  highlight DiagnosticVirtualTextError guifg=#db4b4b
  highlight DiagnosticVirtualTextWarn guifg=#e0af68
  highlight DiagnosticVirtualTextInfo guifg=#0db9d7
  highlight DiagnosticVirtualTextHint guifg=#10b981
]])
