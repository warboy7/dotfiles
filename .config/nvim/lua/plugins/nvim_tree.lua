local function open_win_config_func()
    local scr_w = vim.opt.columns:get()
    local scr_h = vim.opt.lines:get()
    local tree_w = 80
    local tree_h = math.floor(tree_w * scr_h / scr_w)
    return {
        border = "single",
        relative = "editor",
        width = tree_w,
        height = tree_h,
        col = (scr_w - tree_w) / 2,
        row = (scr_h - tree_h) / 2
    }
end

return {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
        "nvim-tree/nvim-web-devicons"
    },
    config = function()
        require("nvim-tree").setup({
            view = {
                signcolumn = "yes",
                float = {
                    enable = true,
                    open_win_config = open_win_config_func
                },
                cursorline = false
            },
            modified = {
                enable = true
            },
            renderer = {
                indent_width = 3,
                icons = {
                    show = {
                        hidden = true
                    },
                    git_placement = "after",
                    bookmarks_placement = "after",
                    symlink_arrow = " -> ",
                    glyphs = {
                        folder = {
                            arrow_closed = " ",
                            arrow_open = " ",
                            default = "",
                            open = "",
                            empty = "",
                            empty_open = "",
                            symlink = "",
                            symlink_open = ""
                        },
                        default = "󱓻",
                        symlink = "󱓻",
                        bookmark = "",
                        modified = "",
                        hidden = "󱙝",
                        git = {
                            unstaged = "×",
                            staged = "",
                            unmerged = "󰧾",
                            untracked = "",
                            renamed = "",
                            deleted = "",
                            ignored = "∅"
                        }
                    }
                }
            },
            filters = {
                git_ignored = false
            },
            hijack_cursor = true,
            sync_root_with_cwd = true
        })
        vim.api.nvim_set_hl(0, "NormalFloat", {
            fg = "none",
            bg = "none",
        })
        vim.keymap.set("n", "<C-n>", vim.cmd.NvimTreeToggle, { desc = "Open Nvim Tree" })
    end,
}
