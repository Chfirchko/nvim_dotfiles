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
map({'n', 'v'}, '<C-_>', '<cmd>lua require("Comment.api").toggle.linewise.current()<CR>', { desc = 'Toggle comment' })
map('v', '<C-_>', '<cmd>lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<CR>', { desc = 'Toggle comment visual' })

-- Альтернатива для некоторых терминалов
map({'n', 'v'}, '<C-/>', '<cmd>lua require("Comment.api").toggle.linewise.current()<CR>', { desc = 'Toggle comment' })
map('v', '<C-/>', '<cmd>lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<CR>', { desc = 'Toggle comment visual' })

-- Резервные mappingи
map({'n', 'v'}, '<leader>c', '<cmd>lua require("Comment.api").toggle.linewise.current()<CR>', { desc = 'Toggle comment' })
map('v', '<leader>c', '<cmd>lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<CR>', { desc = 'Toggle comment visual' })

-- Форматирование кода
map("n", "<leader>f", function()
  vim.lsp.buf.format({ async = true })
end, { desc = "Format code" })

-- Git команды 
map("n", "<leader>gg", "<cmd>LazyGit<CR>", { desc = "Open LazyGit" })


map('n', '<leader>uu', '<cmd>Telescope undo<CR>', { desc = 'Undo history' })
-- УДАЛИТЕ эту строку - она дублируется в plugins.lua
-- map('n', '<leader>u', '<cmd>lua require("undotree").toggle()<CR>'
