require'treesitter-context'.setup{
    enable = true,
    throttle = true,
    max_lines = 0,
    show_all_context = true,
    trim_scope = 'outer',
    patterns = {
        default = {
            'class',
            'function',
            'method',
            'for',
            'while',
            'if',
            'switch',
            'case',
        },
        python = {
            'def'
        },
        rust = {
            'loop_expression',
            'impl_item',
        },
    },
    zindex = 20,
    mode = 'cursor',
    separator = nil,
}
