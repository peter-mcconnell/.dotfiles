return {
  "akinsho/toggleterm.nvim",
  opts = {
    direction = "float",
    float_opts = { border = "curved" },
  },
  keys = {
    {
      "<leader>ac",
      function()
        require("toggleterm.terminal").Terminal
          :new({ cmd = "codex", direction = "float", hidden = true })
          :toggle()
      end,
      desc = "Open Codex",
    },
  },
}
