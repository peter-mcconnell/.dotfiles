require('go').setup()
require('dap-go').setup()
local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
   require('go.format').gofmt()
  end,
  group = format_sync_grp,
})
local format_sync_grp = vim.api.nvim_create_augroup("GoImport", {})
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
   require('go.format').goimport()
  end,
  group = format_sync_grp,
})
local go_status, go = pcall(require, "go")
if go_status then
	go.setup({
		-- NOTE: all LSP and formatting related options are disabeld.
		-- NOTE: LSP is handled by lsp.lua and formatting is handled by null-ls.lua
		-- NOTE: via `lsp_on_attach` the custom callback used by all other LSPs is called
		go = "go", -- go command, can be go[default] or go1.18beta1
		goimport = "gopls", -- goimport command, can be gopls[default] or goimport
		fillstruct = "gopls", -- can be nil (use fillstruct, slower) and gopls
		gofmt = "gofumpt", -- gofmt cmd,
		max_line_len = 128, -- max line length in golines format, Target maximum line length for golines
		tag_transform = false, -- can be transform option("snakecase", "camelcase", etc) check gomodifytags for details and more options
		tag_options = "json=omitempty", -- sets options sent to gomodifytags, i.e., json=omitempty
		gotests_template = "", -- sets gotests -template parameter (check gotests for details)
		gotests_template_dir = "", -- sets gotests -template_dir parameter (check gotests for details)
		comment_placeholder = "", -- comment_placeholder your cool placeholder e.g. ﳑ       
		icons = { breakpoint = "🧘", currentpos = "🏃" }, -- setup to `false` to disable icons setup
		verbose = false, -- output loginf in messages
		lsp_cfg = {
			capabilities = capabilities,
		}, -- true: use non-default gopls setup specified in go/lsp.lua
		-- false: do nothing
		-- if lsp_cfg is a table, merge table with with non-default gopls setup in go/lsp.lua, e.g.
		-- lsp_cfg = {settings={gopls={matcher='CaseInsensitive', ['local'] = 'your_local_module_path', gofumpt = true }}}
		lsp_gofumpt = true, -- true: set default gofmt in gopls format to gofumpt
		lsp_on_attach = on_attach, -- nil: use on_attach function defined in go/lsp.lua,
		-- when lsp_cfg is true
		-- if lsp_on_attach is a function: use this function as on_attach function for gopls
		lsp_codelens = true, -- set to false to disable codelens, true by default
		lsp_keymaps = false, -- set to false to disable gopls/lsp keymap
		lsp_diag_hdlr = true, -- hook lsp diag handler
		lsp_diag_underline = false,
		-- virtual text setup
		lsp_diag_virtual_text = { space = 0, prefix = "ﳑ" },
		lsp_diag_signs = true,
		lsp_diag_update_in_insert = true,
		lsp_document_formatting = false, -- true: use gopls to format, false: use other formatter tool
		lsp_inlay_hints = {
			enable = true,
			-- Only show inlay hints for the current line
			-- only_current_line = false,
			-- Event which triggers a refersh of the inlay hints.
			-- You can make this "CursorMoved" or "CursorMoved,CursorMovedI" but
			-- not that this may cause higher CPU usage.
			-- This option is only respected when only_current_line and
			-- autoSetHints both are true.
			-- only_current_line_autocmd = "CursorHold",
			-- whether to show variable name before type hints with the inlay hints or not
			-- default: false
			-- show_variable_name = true,
			-- prefix for parameter hints
			-- parameter_hints_prefix = " ",
			show_parameter_hints = true,
			-- prefix for all the other hints (type, chaining)
			other_hints_prefix = "=> ",
			-- whether to align to the lenght of the longest line in the file
			max_len_align = false,
			-- padding from the left if max_len_align is true
			max_len_align_padding = 1,
			-- whether to align to the extreme right or not
			right_align = false,
			-- padding from the right if right_align is true
			right_align_padding = 6,
			-- The color of the hints
			highlight = "Comment",
		},
		gopls_cmd = nil, -- if you need to specify gopls path and cmd, e.g {"/home/user/lsp/gopls", "-logfile","/var/log/gopls.log" }
		gopls_remote_auto = true, -- add -remote=auto to gopls
		gocoverage_sign = "█",
		sign_priority = 5, -- change to a higher number to override other signs
		-- dap_debug = false, -- set to false to disable dap
		-- dap_debug_keymap = false, -- true: use keymap for debugger defined in go/dap.lua
		-- false: do not use keymap in go/dap.lua.  you must define your own.
		-- dap_debug_gui = false, -- set to true to enable dap gui, highly recommended
		-- dap_debug_vt = false, -- set to true to enable dap virtual text
		-- build_tags = "", --textobjects = true, -- enable default text jobects through treesittter-text-objects
		test_runner = "dlv", -- richgo, go test, richgo, dlv, ginkgo
		run_in_floaterm = false, -- set to true to run in float window. set default build tags
		-- float term recommend if you use richgo/ginkgo with terminal color
		-- trouble = true, -- true: use trouble to open quickfix
	})
end
