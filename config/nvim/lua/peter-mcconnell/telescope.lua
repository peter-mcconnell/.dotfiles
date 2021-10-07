local job = require("plenary.job")
local finders = require("telescope.finders")
local pickers = require("telescope.pickers")
local sorters = require("telescope.sorters")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local kubeconfig = "/home/peter/.kube/config"

require("telescope").setup({
  defaults = {
  file_sorter = require("telescope.sorters").get_fzy_sorter,
  prompt_prefix = " >",
  color_devicons = true,
  file_previewer = require("telescope.previewers").vim_buffer_cat.new,
  grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
  qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
  mappings = {
    i = {
    ["<C-x>"] = false,
    ["<C-q>"] = actions.send_to_qflist,
    },
  },
  },
  extensions = {
  fzy_native = {
    override_generic_sorter = false,
    override_file_sorter = false,
  },
  },
})

require("telescope").load_extension("fzy_native")

local M = {}
M.search_dotfiles = function()
  require("telescope.builtin").find_files({
  prompt_title = "< ~ Dotfiles ~ >",
  cwd = vim.env.HOME .. "/.dotfiles/",
  hidden = true,
  })
end

M.search_nvim = function()
  require("telescope.builtin").find_files({
  prompt_title = "< ~ VimRC ~ >",
  cwd = vim.env.HOME .. "/.dotfiles/config/nvim/",
  hidden = true,
  })
end

M.k8s_edits = function()
  if not vim.fn.executable("kubectl") then
    error("You don't have kubectl! Install it first.")
    return
  end

  opts = {}
  local popup_opts={}
  opts.get_preview_window = function ()
    return popup_opts.preview
  end

  local results = {}
  job:new({
    command = 'kubectl',
    args = {'get', 'all', '--kubeconfig=' .. kubeconfig, '--all-namespaces', '--no-headers=true'},
    env = {
      PATH = vim.env.PATH,
      ['KUBECONFIG'] = kubeconfig
    },
    on_stderr = function(_, data)
      print("failed running kubectl get all ...")
      print(data)
    end,
    on_stdout = function(_, data)
      table.insert(results, data)
    end,
  }):sync()

  local picker=pickers.new(opts, {
    prompt_title = "scanning k8s all",
    finder = finders.new_table({
      results = results,
      opts = opts,
    }),
    sorter = conf.generic_sorter(opts),
    attach_mappings = function(pbfr, map)
      map("i", "<CR>", function()
        local choice = action_state.get_selected_entry(pbfr)
        local choice_ns = string.match(choice.value, "^[^ ]+")
        local choice_obj = string.match(choice.value, "[ ]+[^ ]+"):gsub("%s", "")
        vim.cmd('! tmux neww kubectl edit --kubeconfig=' .. kubeconfig .. ' ' .. choice_obj .. ' -n ' .. choice_ns)
      end)
      return true
    end,
  })


  local line_count = vim.o.lines - vim.o.cmdheight
  if vim.o.laststatus ~= 0 then
    line_count = line_count - 1
  end
  popup_opts = picker:get_window_options(vim.o.columns, line_count)
  picker:find()
end

return M
