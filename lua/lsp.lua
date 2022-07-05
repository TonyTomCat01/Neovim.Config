return function()
    local lspconfig = require "lspconfig"

    local servers = {
        "cssls",
        "pyright",
        "emmet_ls",
        "sumneko_lua",
        "hls",
        "clangd",
        "tsserver"
    }

    vim.diagnostic.config(
        {
            virtual_text = false
        }
    )

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

    for _, lsp in ipairs(servers) do
        lspconfig[lsp].setup {
            -- on_attach = my_custom_on_attach,
            capabilities = capabilities
        }
    end
end
