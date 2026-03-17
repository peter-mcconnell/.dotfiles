# Neovim Keymaps

## Claude

| Key | Action |
|---|---|
| `<leader>c` | Claude prompt |

## Debug (DAP) - `<leader>d` prefix

| Key | Action |
|---|---|
| `<leader>db` | Toggle breakpoint |
| `<leader>dB` | Conditional breakpoint (prompts for condition) |
| `<leader>dt` | Debug nearest test (Delve) |
| `<leader>dl` | Re-debug last test |
| `<leader>dc` | Continue / start debug session |
| `<leader>ds` | Step over |
| `<leader>di` | Step into |
| `<leader>do` | Step out |
| `<leader>dr` | Restart debug session |
| `<leader>dx` | Terminate debug session |
| `<leader>du` | Toggle DAP UI |
| `<leader>de` | Eval expression under cursor |

## Go

| Key | Action |
|---|---|
| `tf` | Run nearest test function (floaterm) |
| `ts` | Run test subcase |
| `cl` | Code lens action |

## Navigation

| Key | Action |
|---|---|
| `pj` | Move to pane below |
| `pk` | Move to pane above |
| `pl` | Move to pane right |
| `ph` | Move to pane left |

## Diagnostics

| Key | Action |
|---|---|
| `[d` | Previous diagnostic |
| `]d` | Next diagnostic |
| `<leader>e` | Open diagnostic float |
| `<leader>q` | Diagnostics to loclist |