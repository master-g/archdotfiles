require("nvchad.options")

-- add yours here!

local o = vim.o
o.cursorlineopt = "both" -- to enable cursorline!
o.tabstop = 4
o.shiftwidth = 4

-- enable inlay hint
vim.lsp.inlay_hint.enable(true)

-- gui font
-- vim.o.guifont = "MonoLisa Variable:h12"
-- neovide
vim.g.neovide_cursor_vfx_mode = "railgun"
vim.g.neovide_input_macos_option_key_is_meta = "only_left"

-- dash
vim.api.nvim_create_autocmd("BufDelete", {
	callback = function()
		local bufs = vim.t.bufs
		if #bufs == 1 and vim.api.nvim_buf_get_name(bufs[1]) == "" then
			vim.cmd("Nvdash")
		end
	end,
})
