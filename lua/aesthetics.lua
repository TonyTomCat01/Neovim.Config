P, Onedark = pcall(require, "onedarkpro")

if not P then
    return
end

Onedark.setup(
    {
        theme = "onedark",
        colors = {}, -- Override default colors by specifying colors for 'onelight' or 'onedark' themes
        hlgroups = {
            WinSeparator = {fg = "#1e222a"}
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

Todosetup = {
    signs = true, -- show icons in the signs column
    sign_priority = 8, -- sign priority
    -- keywords recognized as todo comments
    keywords = {
        FIX = {
            icon = " ", -- icon used for the sign, and in search results
            color = "error", -- can be a hex color, or a named color (see below)
            alt = {"FIXME", "BUG", "FIXIT", "ISSUE"} -- a set of other keywords that all map to this FIX keywords
            -- signs = false, -- configure signs for some keywords individually
        },
        TODO = {icon = " ", color = "info"},
        HACK = {icon = " ", color = "warning"},
        WARN = {icon = " ", color = "warning", alt = {"WARNING", "XXX"}},
        PERF = {icon = " ", alt = {"OPTIM", "PERFORMANCE", "OPTIMIZE"}},
        NOTE = {icon = " ", color = "hint", alt = {"INFO"}}
    },
    merge_keywords = true, -- when true, custom keywords will be merged with the defaults
    -- highlighting of the line containing the todo comment
    -- * before: highlights before the keyword (typically comment characters)
    -- * keyword: highlights of the keyword
    -- * after: highlights after the keyword (todo text)
    highlight = {
        before = "", -- "fg" or "bg" or empty
        keyword = "wide", -- "fg", "bg", "wide" or empty. (wide is the same as bg, but will also highlight surrounding characters)
        after = "fg", -- "fg" or "bg" or empty
        pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlightng (vim regex)
        comments_only = true, -- uses treesitter to match keywords in comments only
        max_line_len = 400, -- ignore lines longer than this
        exclude = {} -- list of file types to exclude highlighting
    },
    -- list of named colors where we try to extract the guifg from the
    -- list of hilight groups or use the hex color if hl not found as a fallback
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
        -- regex that will be used to match keywords.
        -- don't replace the (KEYWORDS) placeholder
        pattern = [[\b(KEYWORDS):]] -- ripgrep regex
        -- pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
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
    },
    filetype_exclude = {
        "dashboard"
    }
}

_, Autopairs = pcall(require, "nvim-autopairs")

_, Comment = pcall(require, "Comment")

return function()
    Onedark.load()
    Todo.setup(Todosetup)
    Indent.setup(Indentsetup)
    Autopairs.setup {}
    Comment.setup()
end
