-- ~/.config/nvim/init.lua
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"
require("core.keymaps")
require("core.options")

vim.g.mapleader = " "
vim.g.maplocalleader = " "
-- Затем плагины
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")

-- Включить системный буфер обмена
vim.opt.clipboard = "unnamedplus"

-- Дополнительные удобные маппинги
vim.keymap.set('v', '<C-c>', '"+y', { desc = "Copy to system clipboard" })
vim.keymap.set('n', '<C-v>', '"+p', { desc = "Paste from system clipboard" })
vim.keymap.set('i', '<C-v>', '<C-o>"+p', { desc = "Paste from system clipboard" })

-- Для визуального подтверждения
print("Clipboard configured: " .. vim.opt.clipboard:get())
