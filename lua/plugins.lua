return function()
    require("packer").startup(
        function()
            -- General
            use "wbthomason/packer.nvim"
            use "lewis6991/impatient.nvim"
            use "olimorris/onedarkpro.nvim"
            use "windwp/nvim-autopairs"
            use "lukas-reineke/indent-blankline.nvim"
            use {"elkowar/yuck.vim", ft = "yuck"}
            use {"eraserhd/parinfer-rust", after = "yuck.vim"}
            use {
                "mg979/vim-visual-multi",
                branch = "master"
            }
            use "numToStr/Comment.nvim"
            use {
                "nvim-telescope/telescope.nvim",
                requires = {"nvim-lua/plenary.nvim"},
            }

            -- Aesthetics
            use "kyazdani42/nvim-web-devicons"

            use "rebelot/heirline.nvim"
            use {
                "norcalli/nvim-colorizer.lua",
                opt = true,
                cmd = {"ColorizerAttachToBuffer", "ColorizerDetachFromBuffer", "ColorizerToggle"}
            }
            use {
                "mhartington/formatter.nvim"
            }

            use "nvim-treesitter/nvim-treesitter"

            use "folke/todo-comments.nvim"

            -- LSP Powerhousing
            use "neovim/nvim-lspconfig"
            use "hrsh7th/nvim-cmp"
            use "hrsh7th/cmp-buffer"
            use "hrsh7th/cmp-path"
            use "hrsh7th/cmp-cmdline"
            use "hrsh7th/cmp-nvim-lsp"
            use "L3MON4D3/LuaSnip"

            use {
                "folke/trouble.nvim",
                opt = true,
                cmd = {"Trouble", "TroubleClose", "TroubleToggle", "TroubleRefresh"},
                requires = "kyazdani42/nvim-web-devicons",
                config = function()
                    require("trouble").setup {}
                end
            }
        end
    )
end
