local M = {}

local settings = {
    Lua = {
        runtime = {
            version = "LuaJIT",
        },
        diagnostics = {
            globals = {
                "vim",
                "use",
                "describe",
                "it",
                "assert",
                "before_each",
                "after_each",
            },
        },
        workspace ={
            library = vim.api.nvim_get_runtime_file("", true)
        },
        disable = {
            "lowercase-global",
            "undefined-global",
            "unused-local",
            "unused-function",
            "unused-vararg",
            "trailing-space",
        },
    },
}

M.setup = function(on_attach, capabilities)
    local lspconfig = require "lspconfig"

    lspconfig.lua_ls.setup {
        on_attach = function(client, bufnr)
            client.server_capabilities.document_formatting = false
            client.server_capabilities.document_range_formatting = false
            on_attach(client, bufnr)
        end,
        settings = settings,
        flags = {
            debounce_text_changes = 150,
        },
        capabilities = capabilities,
    }
end

return M
