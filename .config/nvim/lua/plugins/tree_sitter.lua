return {
    "nvim-treesitter/nvim-treesitter",
    branch = master, 
    lazy = false, 
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = { "c", "python", "rust", "lua" },
            sync_install = false,
            highlight = { enable = true },
            indent = { enalbe = true },
        })
    end
}
