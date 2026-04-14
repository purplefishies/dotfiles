-- --- Bootstrap lazy.nvim ---
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git","clone","https://github.com/folke/lazy.nvim.git", lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

-- --- Plugins ---
require("lazy").setup({
  { "nvim-lualine/lualine.nvim" },        -- powerline-style statusline
  { "nvim-tree/nvim-web-devicons" },      -- icons
  { "ellisonleao/gruvbox.nvim" },         -- colorscheme
})

-- --- UI ---
vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.termguicolors = true
vim.opt.cursorline = true

-- --- Colors ---
vim.cmd("colorscheme gruvbox")

-- --- Lualine (Powerline style) ---
require("lualine").setup({
  options = {
    theme = "gruvbox",
    section_separators = { left = "", right = "" },
    component_separators = { left = "", right = "" },
  },
})

-- --- Nice extras ---
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.scrolloff = 8

-- --- Keymaps ---
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>w", ":w<CR>")
vim.keymap.set("n", "<leader>q", ":q<CR>")



