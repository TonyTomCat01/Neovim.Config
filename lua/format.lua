
return function ()
    local util = require("formatter.util")
    require("formatter").setup(
        {
            filetype = {
                lua = {
                    function()
                        return {
                            exe = "luafmt",
                            args = {"--indent-count", 4, "--stdin"},
                            stdin = true
                        }
                    end
                },
                haskell = {
                    function()
                        return {
                            exe = "fourmolu",
                            args = {"--no-cabal"},
                            stdin = true
                        }
                    end
                },
                -- javascript = {
                --     function()
                --         return {
                --             exe = "prettier",
                --             args = {
                --                 "--stdin-filepath",
                --                 "--tab-width",
                --                 4,
                --                 util.escape_path(util.get_current_buffer_file_path())
                --             },
                --             stdin = true
                --         }
                --     end
                -- },
                html = {
                    function()
                        return {
                            exe = "prettier",
                            args = {
                                "--stdin-filepath",
                                util.escape_path(util.get_current_buffer_file_path())
                            },
                            stdin = true
                        }
                    end
                },
                css = {
                    function()
                        return {
                            exe = "prettier",
                            args = {
                                "--stdin-filepath",
                                util.escape_path(util.get_current_buffer_file_path())
                            },
                            stdin = true
                        }
                    end
                },
                cpp = {
                    -- clang-format
                    function()
                        return {
                            exe = "clang-format",
                            args = {
                                "--assume-filename",
                                vim.api.nvim_buf_get_name(0),
                                '-style="{BasedOnStyle: llvm, IndentWidth: 8}"'
                            },
                            stdin = true,
                            cwd = vim.fn.expand("%:p:h") -- Run clang-format in cwd of the file.
                        }
                    end
                },
                c = {
                    -- clang-format
                    function()
                        return {
                            exe = "clang-format",
                            args = {"--assume-filename", vim.api.nvim_buf_get_name(0)},
                            stdin = true,
                            cwd = vim.fn.expand("%:p:h") -- Run clang-format in cwd of the file.
                        }
                    end
                }
            }
        }
)
end
