local p, heirline = pcall(require, "heirline")

if not p then
    return
end

local conditions = require("heirline.conditions")
local utils = require("heirline.utils")

local colors = {
    none = "NONE",
    bg = "#282c34",
    bg2 = "#21252b",
    bg_visual = "#393f4a",
    darker_black = "#1b1f27",
    black = "#1e222a", --  nvim bg
    black2 = "#252931",
    border = "#646e82",
    teal = "#a1eaf7",
    fg = "#abb2bf",
    fg_light = "#adbac7",
    fg_dark = "#798294",
    fg_gutter = "#5c6370",
    dark5 = "#abb2bf",
    blue = "#61afef",
    cyan = "#56b6c2",
    purple = "#c678dd",
    orange = "#d19a66",
    yellow = "#e5c07b",
    yellow2 = "#e2c08d",
    bg_yellow = "#ebd09c",
    green = "#98c379",
    red = "#e86671",
    red1 = "#f65866",
    git = {change = "#e0af68", add = "#109868", delete = "#9A353D", conflict = "#bb7a61"},
    gitSigns = {change = "#e0af68", add = "#109868", delete = "#9A353D"},
    diagnostics = {
        error = "#db4b4b",
        hint = "#1abc9c",
        info = "#0db9d7",
        warn = "#e0af68"
    }
}

local ViMode = {
    init = function(self)
        self.mode = vim.fn.mode(1) -- :h mode()
    end,
    static = {
        mode_names = {
            n = "NORMAL",
            no = "N?",
            nov = "N?",
            noV = "N?",
            ["no\22"] = "N?",
            niI = "Ni",
            niR = "Nr",
            niV = "Nv",
            nt = "NTERMINAL",
            v = "VISUAL",
            vs = "V",
            V = "VISUAL",
            Vs = "Vs",
            ["\22"] = "VISUAL",
            ["\22s"] = "VISUAL",
            s = "S",
            S = "S_",
            ["\19"] = "^S",
            i = "INSERT",
            ic = "Ic",
            ix = "Ix",
            R = "REPLACE",
            Rc = "Rc",
            Rx = "Rx",
            Rv = "Rv",
            Rvc = "Rv",
            Rvx = "Rv",
            c = "COMMAND",
            cv = "Ex",
            r = "...",
            rm = "M",
            ["r?"] = "?",
            ["!"] = "!",
            t = "TERMINAL"
        },
        mode_colors = {
            n = colors.red,
            i = colors.purple,
            v = colors.blue,
            V = colors.blue,
            ["\22"] = colors.cyan,
            c = colors.orange,
            s = colors.purple,
            S = colors.purple,
            ["\19"] = colors.purple,
            R = colors.green,
            r = colors.green,
            ["!"] = colors.red,
            t = colors.red
        }
    },
    {
        provider = function()
            return " ﬘ "
        end,
        hl = function(self)
            local mode = self.mode:sub(1, 1) -- get only the first mode character
            return {bg = self.mode_colors[mode], fg = colors.black}
        end
    },
    {
        provider = function(self)
            return " " .. self.mode_names[self.mode]
        end,
        hl = function(self)
            local mode = self.mode:sub(1, 1) -- get only the first mode character
            return {fg = self.mode_colors[mode], bg = colors.black}
        end
    }
}

local FileNameBlock = {
    init = function(self)
        self.filename = vim.api.nvim_buf_get_name(0)
    end
}

local FileIcon = {
    init = function(self)
        local filename = self.filename
        local extension = vim.fn.fnamemodify(filename, ":e")
        self.icon, self.icon_color = require("nvim-web-devicons").get_icon_color(filename, extension, {default = true})
    end,
    provider = function(self)
        return self.icon and (self.icon .. " ")
    end,
    hl = function(self)
        return {fg = self.icon_color, bg = colors.black}
    end
}

local FileName = {
    provider = function(self)
        local filename = vim.fn.fnamemodify(self.filename, ":.")
        if filename == "" then
            return "Scratch"
        end
        if not conditions.width_percent_below(#filename, 0.25) then
            filename = vim.fn.pathshorten(filename)
        end
        return filename
    end,
    hl = {fg = colors.cyan, bg = colors.black}
}

local FileFlags = {
    {
        provider = function()
            if vim.bo.modified then
                return "  "
            end
        end,
        hl = {fg = colors.purple, bg = colors.black}
    },
    {
        provider = function()
            if (not vim.bo.modifiable) or vim.bo.readonly then
                return "  "
            end
        end,
        hl = {fg = colors.orange, bg = colors.black}
    }
}

local FileNameModifer = {
    hl = function()
        if vim.bo.modified then
            return {fg = colors.cyan}
        end
    end
}

FileNameBlock =
    utils.insert(FileNameBlock, FileIcon, utils.insert(FileNameModifer, FileName), unpack(FileFlags), {provider = "%<"})

local Ruler = {
    {
        provider = function()
            return "   "
        end,
        hl = {
            bg = colors.teal,
            fg = colors.black
        }
    },
    {
        provider = " %P",
        hl = {
            bg = colors.black,
            fg = colors.teal
        }
    }
}

local MainIcon = {
    provider = function()
        return "   "
    end,
    hl = {
        fg = colors.black,
        bg = colors.cyan
    }
}

local LSP = {
    condition = conditions.lsp_attached,
    provider = function()
        local names = {}
        for i, server in pairs(vim.lsp.buf_get_clients(0)) do
            table.insert(names, server.name)
        end
        return " 力 "
    end,
    hl = {fg = colors.orange, bg = colors.black}
}

local Align = {provider = "%="}
local Space = {provider = " "}

local TerminalName = {
    {
        provider = function()
            return "  "
        end,
        hl = {
            fg = colors.black,
            bg = colors.blue
        }
    },
    {
        provider = function()
            local tname, _ = vim.api.nvim_buf_get_name(0):gsub(".*:", "")
            return " " .. tname
        end,
        hl = {fg = colors.blue, bg = colors.black}
    }
}

local TerminalStatusline = {
    hl = {bg = colors.black},
    condition = function()
        return conditions.buffer_matches({buftype = {"terminal"}})
    end,
    --hl = {bg = colors.dark_red},
    {condition = conditions.is_active},
    TerminalName,
    Align,
    ViMode,
    Space
}

local statusline = {
    hl = {bg = colors.black},
    MainIcon,
    Space,
    LSP,
    Space,
    FileNameBlock,
    Align,
    ViMode,
    Space,
    Ruler
}

local StatusLines = {
    init = utils.pick_child_on_condition,
    TerminalStatusline,
    statusline
}

return function()
    heirline.setup(StatusLines)
end
