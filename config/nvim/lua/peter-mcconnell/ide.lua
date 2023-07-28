--
-- note: currently disabled. keeping incase I want to try nvim-ide out again
--
local bufferlist      = require('ide.components.bufferlist')
local explorer        = require('ide.components.explorer')
local outline         = require('ide.components.outline')
local callhierarchy   = require('ide.components.callhierarchy')
local timeline        = require('ide.components.timeline')
local changes         = require('ide.components.changes')
local commits         = require('ide.components.commits')
local branches        = require('ide.components.branches')
local bookmarks       = require('ide.components.bookmarks')

require('ide').setup({
    icon_set = "default",
    log_level = "info",
    components = {
        global_keymaps = {
        },
    },
    -- default panel groups to display on left and right.
    panels = {
        left = "explorer",
        right = "git"
    },
    panel_groups = {
        explorer = { explorer.Name, outline.Name, bufferlist.Name, bookmarks.Name, callhierarchy.Name },
        git = { changes.Name, commits.Name, timeline.Name, branches.Name }
    },
    workspaces = {
        auto_open = 'none',
    },
    panel_sizes = {
        left = 30,
        right = 30,
        bottom = 15
    }
})

vim.api.nvim_set_keymap("n", "<leader>]", "<cmd>Workspace RightPanelToggle<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<leader>[", "<cmd>Workspace LeftPanelToggle<CR>", {noremap = true, silent = true})
