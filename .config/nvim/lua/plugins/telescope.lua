return {
    "nvim-telescope/telescope.nvim", tag = "0.1.8",
    dependencies = {
        "nvim-lua/plenary.nvim"
    },
    config = function()
        require("telescope").setup({})
        vim.keymap.set('n', '<C-p>', require('telescope.builtin').find_files)
        vim.keymap.set('n', '<leader>lg', require('telescope.builtin').live_grep)
    end
}
