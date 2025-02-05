local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp_zero.default_keymaps({buffer = bufnr})
end)

require('lspconfig').lua_ls.setup({})
require('lspconfig').bashls.setup({})
require('lspconfig').ccls.setup({})
require('lspconfig').clangd.setup({})
require('lspconfig').cmake.setup({})
require('lspconfig').gopls.setup({})
require('lspconfig').pyright.setup({})
require('lspconfig').tflint.setup({})
require('lspconfig').rust_analyzer.setup({})

require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {},
  handlers = {
    lsp_zero.default_setup,
  },
})

-- cursor hold
vim.o.updatetime = 250
vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
  group = vim.api.nvim_create_augroup("float_diagnostic", { clear = true }),
  callback = function ()
    vim.diagnostic.open_float(nil, {focus=false})
  end
})
