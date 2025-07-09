return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
        options = {
            icons_enabled = true,
            theme = 'ayu_dark',
            section_separators = '',
            component_separators = '',
        },
        sections = {
            lualine_x = {
                'lsp_status',
                'encoding',
                'fileformat',
                'filetype'
            }
        }
    }
}
