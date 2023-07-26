require('toggleterm').setup({
  open_mapping = [[<c-\>]],
  direction = "float",
})

local Terminal  = require('toggleterm.terminal').Terminal
local myterm = Terminal:new({
  dir = "git_dir",
  direction = "float",
  float_opts = {
    border = "curved",
  },
  persist_mode = true,
  persist_size = true,
  shade_terminals = true,
  auto_scroll = true,
})

function _myterm_toggle()
  myterm:toggle()
end

vim.api.nvim_set_keymap("n", "<leader>t", "<cmd>lua _myterm_toggle()<CR>", {noremap = true, silent = true})
