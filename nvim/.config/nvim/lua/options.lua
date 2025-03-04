require "nvchad.options"

-- add yours here!

local o = vim.o
o.cursorlineopt ='both' -- to enable cursorline!
o.tabstop = 4
o.shiftwidth = 4

-- enable inlay hint
vim.lsp.inlay_hint.enable(true)

-- gui font
-- vim.o.guifont = "MonoLisa Variable:h12"
-- neovide
vim.g.neovide_cursor_vfx_mode = "railgun"
