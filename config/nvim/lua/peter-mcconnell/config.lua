--[[
-- support a custom .nvimconfig file in a projects root to dynamically load
-- neovim variables at runtime, per project
]]
local function is_directory(path)
    local f = io.open(path, "r")
    if f then
        local _, _, code = f:read(1)
        f:close()
        return code == 21
    end
    return false
end

local function file_or_dir_exists(path)
    local f = io.open(path, "r")
    if f then
        f:close()
        return true
    end
    return false
end

local function find_project_root()
    local path = vim.fn.getcwd()

    while path ~= "" and path ~= "/" do
        if file_or_dir_exists(path .. "/.nvimconfig") or
           file_or_dir_exists(path .. "/go.mod") or
           is_directory(path .. "/.git") then
            return path
        end

        path = vim.fn.fnamemodify(path, ":h")
    end

    return nil
end

vim.api.nvim_create_autocmd("FileType", {
    pattern = "*",
    callback = function()
        local root = find_project_root()
        if root ~= '' then
            local config_file = root .. '/.nvimconfig'
            if vim.fn.filereadable(config_file) == 1 then
                vim.cmd('source ' .. config_file)
            end
        end
    end
})
