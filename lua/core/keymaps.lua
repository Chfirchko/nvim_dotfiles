-- Базовые mappingи
local map = vim.keymap.set
local default_opts = { noremap = true, silent = true }

-- Самый важный mapping - выход из режима вставки через jj
map("i", "jj", "<Esc>", default_opts)

-- Управление окнами
map("n", "<C-h>", "<C-w>h", default_opts)
map("n", "<C-j>", "<C-w>j", default_opts)
map("n", "<C-k>", "<C-w>k", default_opts)
map("n", "<C-l>", "<C-w>l", default_opts)

-- РАБОЧИЕ mappingи для Comment.nvim
vim.keymap.set({'n', 'v'}, '<C-_>', '<cmd>lua require("Comment.api").toggle.linewise.current()<CR>', { desc = 'Toggle comment' })
vim.keymap.set('v', '<C-_>', '<cmd>lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<CR>', { desc = 'Toggle comment visual' })

-- Альтернатива для некоторых терминалов
vim.keymap.set({'n', 'v'}, '<C-/>', '<cmd>lua require("Comment.api").toggle.linewise.current()<CR>', { desc = 'Toggle comment' })
vim.keymap.set('v', '<C-/>', '<cmd>lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<CR>', { desc = 'Toggle comment visual' })

-- Резервные mappingи
vim.keymap.set({'n', 'v'}, '<leader>c', '<cmd>lua require("Comment.api").toggle.linewise.current()<CR>', { desc = 'Toggle comment' })
vim.keymap.set('v', '<leader>c', '<cmd>lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<CR>', { desc = 'Toggle comment visual' })-- Лидер (пробел)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Форматирование кода
map("n", "<leader>f", function()
  vim.lsp.buf.format({ async = true })
end, { desc = "Format code" })

-- Git команды
map("n", "<leader>gg", "<cmd>LazyGit<CR>", { desc = "Open LazyGit" })

-- vim.keymap.set('n', '<leader>uo', require('undotree').open, { noremap = true, silent = true })
-- vim.keymap.set('n', '<leader>uc', require('undotree').close, { noremap = true, silent = true })


