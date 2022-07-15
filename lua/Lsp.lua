return function()
    local lspconfig = require "lspconfig"

    local servers = {
        "cssls",
        "pyright",
        "emmet_ls",
        "sumneko_lua",
        "hls",
        "rust_analyzer",
        "clangd",
        "tsserver"
    }

    vim.diagnostic.config(
        {
            virtual_text = false,
            update_in_insert = true,
            underline = true,
            severity_sort = true
        }
    )

    -- local caps = vim.lsp.protocol.make_client_capabilities()
    -- caps = require("cmp_nvim_lsp").update_capabilities(caps)

    for _, lsp in ipairs(servers) do
        lspconfig[lsp].setup {}
    end
end
