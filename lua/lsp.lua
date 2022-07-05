local lspconfig = require "lspconfig"

lspconfig.clangd.setup {}

lspconfig.cssls.setup {}

lspconfig.tsserver.setup {}

lspconfig.emmet_ls.setup {}

lspconfig.pyright.setup {}

lspconfig.sumneko_lua.setup {}

lspconfig.purescriptls.setup{}

lspconfig.hls.setup {}

vim.diagnostic.config(
    {
        virtual_text = false
    }
)

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

local servers = {
    "cssls",
    "pyright",
    "emmet_ls",
    "sumneko_lua",
    "clangd",
    "tsserver"
}

for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {
        -- on_attach = my_custom_on_attach,
        capabilities = capabilities
    }
end

return function ()
end
