vim.g.mapleader = ' ' 
vim.opt.number = false	 
vim.opt.relativenumber = true 
vim.opt.wrap = false
vim.opt.swapfile = false










require("config.lazy")












vim.keymap.set('n','<leader>o',':update <CR>:source init.lua<CR>')
vim.keymap.set('n','<leader>w',':w<CR>')
vim.keymap.set('n','<leader>q',':q<CR>')
vim.keymap.set('n', '<leader>pv', ':Oil<CR>')


