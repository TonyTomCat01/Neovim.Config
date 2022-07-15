P, Onedark = pcall(require, "onedarkpro")

if not P then
    return
end

Onedark.setup(
    {
        theme = "onedark",
        colors = {}, -- Override default colors by specifying colors for 'onelight' or 'onedark' themes
        hlgroups = {
            WinSeparator = {fg = "#1e222a"},
            VertSplit = {fg = "#1e222a"}
        },
        filetype_hlgroups = {}, -- Override default highlight groups for specific filetypes
        plugins = {
            -- Override which plugins highlight groups are loaded
            native_lsp = true,
            polygot = true,
            treesitter = true
            -- NOTE: Other plugins have been omitted for brevity
        },
        styles = {
            strings = "NONE", -- Style that is applied to strings
            comments = "italic", -- Style that is applied to comments
            keywords = "italic", -- Style that is applied to keywords
            functions = "italic", -- Style that is applied to functions
            variables = "NONE", -- Style that is applied to variables
            virtual_text = "italic" -- Style that is applied to virtual text
        },
        options = {
            bold = false, -- Use the themes opinionated bold styles?
            italic = true, -- Use the themes opinionated italic styles?
            underline = true, -- Use the themes opinionated underline styles?
            undercurl = true, -- Use the themes opinionated undercurl styles?
            cursorline = true, -- Use cursorline highlighting?
            transparency = false, -- Use a transparent background?
            terminal_colors = true, -- Use the theme's colors for Neovim's :terminal?
            window_unfocussed_color = false -- When the window is out of focus, change the normal background?
        }
    }
)

P, Todo = pcall(require, "todo-comments")

if not P then
    return
end

local hl = require("todo-comments.highlight")
local highlight_win = hl.highlight_win
hl.highlight_win = function(win, force)
    pcall(highlight_win, win, force)
end

Todosetup = {
    signs = true,
    sign_priority = 8,
    keywords = {
        FIX = {
            icon = " ",
            color = "error",
            alt = {"FIXME", "BUG", "FIXIT", "ISSUE"}
            -- signs = false, -- configure signs for some keywords individually
        },
        TODO = {icon = " ", color = "info"},
        HACK = {icon = " ", color = "warning"},
        WARN = {icon = " ", color = "warning", alt = {"WARNING", "XXX"}},
        PERF = {icon = " ", alt = {"OPTIM", "PERFORMANCE", "OPTIMIZE"}},
        NOTE = {icon = " ", color = "hint", alt = {"INFO"}}
    },
    merge_keywords = true,
    highlight = {
        before = "",
        keyword = "wide",
        after = "fg",
        pattern = [[.*<(KEYWORDS)\s*:]],
        comments_only = true,
        max_line_len = 400,
        exclude = {}
    },
    colors = {
        error = {"DiagnosticError", "ErrorMsg", "#DC2626"},
        warning = {"DiagnosticWarning", "WarningMsg", "#FBBF24"},
        info = {"DiagnosticInfo", "#2563EB"},
        hint = {"DiagnosticHint", "#10B981"},
        default = {"Identifier", "#7C3AED"}
    },
    search = {
        command = "rg",
        args = {
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column"
        },
        pattern = [[\b(KEYWORDS):]] -- ripgrep regex
        --pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
    }
}

_, Indent = pcall(require, "indent_blankline")

Indentsetup = {
    show_end_of_line = true,
    show_current_context = true,
    show_current_context_start = true,
    buftype_exclude = {
        "terminal",
        "packer",
        "lspinfo",
        "help"
    }
}

_, Autopairs = pcall(require, "nvim-autopairs")

_, Comment = pcall(require, "Comment")

NvimTreeSetup = {
    update_focused_file = {
        enable = true,
        update_cwd = true
    },
    renderer = {
        root_folder_modifier = ":t",
        icons = {
            glyphs = {
                default = "",
                symlink = "",
                folder = {
                    arrow_open = "",
                    arrow_closed = "",
                    default = "",
                    open = "",
                    empty = "",
                    empty_open = "",
                    symlink = "",
                    symlink_open = ""
                },
                git = {
                    unstaged = "",
                    staged = "S",
                    unmerged = "",
                    renamed = "➜",
                    untracked = "U",
                    deleted = "",
                    ignored = "◌"
                }
            }
        }
    },
    diagnostics = {
        enable = true,
        show_on_dirs = true,
        icons = {
            hint = "",
            info = "",
            warning = " ",
            error = ""
        }
    },
    view = {
        width = 30,
        height = 30,
        side = "left",
        mappings = {}
    }
}

return function()
    Onedark.load()
    Todo.setup(Todosetup)
    Indent.setup(Indentsetup)
    Autopairs.setup {}
    Comment.setup()
    require("nvim-tree").setup(NvimTreeSetup)
end
