local previewers = require("telescope.previewers")
local Job = require("plenary.job")
local new_maker = function(filepath, bufnr, opts)
    filepath = vim.fn.expand(filepath)
    Job:new(
        {
            command = "file",
            args = {"--mime-type", "-b", filepath},
            on_exit = function(j)
                local mime_type = vim.split(j:result()[1], "/")[1]
                if mime_type == "text" then
                    previewers.buffer_previewer_maker(filepath, bufnr, opts)
                else
                    -- maybe we want to write something to the buffer here
                    vim.schedule(
                        function()
                            vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, {"Binary"})
                        end
                    )
                end
            end
        }
    ):sync()
end

return function()
    require("telescope").setup {
        defaults = {
            buffer_previewer_maker = new_maker,
            mappings = {
                i = {
                    ["<C-u>"] = false
                }
            }
        },
        pickers = {
            find_files = {
                mappings = {
                    n = {
                        ["cd"] = function(prompt_bufnr)
                            local selection = require("telescope.actions.state").get_selected_entry()
                            local dir = vim.fn.fnamemodify(selection.path, ":p:h")
                            require("telescope.actions").close(prompt_bufnr)
                            vim.cmd(string.format("silent lcd %s", dir))
                        end
                    }
                }
            }
        }
    }
end
