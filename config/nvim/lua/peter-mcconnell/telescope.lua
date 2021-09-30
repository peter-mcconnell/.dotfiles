local actions = require("telescope.actions")
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

M.k8s_edit_svc = function()
    local handle = assert(io.popen('kubectl get svc --all-namespaces | tail -n +2'))
    local results = {}
    for line in handle:lines() do
      table.insert(results, line)
    end
    handle.close()
    require("telescope.pickers").new({}, {
        prompt_title = "k8s service",
        finder = require("telescope.finders").new_table({
            results = results,
        }),
        sorter = require("telescope.config").values.generic_sorter({}),
        attach_mappings = function(pbfr, map)
          map("i", "<CR>", function()
            -- take the stdout row and parse the 'columns'
            local choice = require("telescope.actions.state").get_selected_entry(pbfr)
            local choice_ns = string.match(choice.value, "^[^ ]+")
            -- this is horrible - there has to be a cleaner way to do this in lua
            local choice_svc = string.match(choice.value, "[ ]+[^ ]+"):gsub("%s", "")
            vim.cmd('! tmux neww kubectl edit svc ' .. choice_svc .. ' -n ' .. choice_ns)
            -- TODO: look at a vim only solution. might need to avoid kubectl edit?
            -- local handle = assert(io.popen('kubectl get svc ' .. choice_svc .. ' -n ' .. choice_ns .. ' -o yaml'))
            -- local yaml = handle:read("*a")
            -- handle.close()
            require("telescope.actions").close(pbfr)
          end)
          return true
        end,
    }):find()
end

return M
