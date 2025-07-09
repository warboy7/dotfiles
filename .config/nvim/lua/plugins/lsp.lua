return {
    "neovim/nvim-lspconfig",
    config = function ()
        local on_attach = function(_, bufnr)
            local nmap = function(keys, func, desc)
                if desc then
                    desc = 'LSP: ' .. desc
                end

                vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
            end

            nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
            nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

            nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
            nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
            nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
            nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
            nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
            nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

            -- See `:help K` for why this keymap
            nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
            nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

            -- Lesser used LSP functionality
            nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
            nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
            nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
            nmap('<leader>wl', function()
                print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end, '[W]orkspace [L]ist Folders')

            -- Inlay hints
            nmap('<leader>ih', function ()
                vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({0}),{0})
            end, 'Enable [I]nlay [H]ints')



        -- Create a command `:Format` local to the LSP buffer
        vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
                vim.lsp.buf.format()
            end, { desc = 'Format current buffer with LSP' })
        end

        local hover = vim.lsp.buf.hover
        ---@diagnostic disable-next-line: duplicate-set-field
        vim.lsp.buf.hover = function()
            return hover({
                border = 'rounded'
            })
        end
        local signature_help = vim.lsp.buf.signature_help
        ---@diagnostic disable-next-line: duplicate-set-field
        vim.lsp.buf.signature_help = function()
            return signature_help({
                border = 'rounded'
            })
        end

        vim.diagnostic.config({
            virtual_lines = {
                current_line = true
            },
            underline = false
        })

        local capabilities = require('cmp_nvim_lsp').default_capabilities()

        -- lua_ls
        vim.lsp.config('lua_ls', {
            on_attach = on_attach,
            capabilities = capabilities,
            settings = {
                Lua = {
                    diagnostics = {
                        globals = {
                            "vim"
                        }
                    }
                }
            }
        })
        vim.lsp.enable('lua_ls')

        -- pyright
        vim.lsp.config('pyright', {
            on_attach = on_attach,
            capabilities = capabilities,
        })
        vim.lsp.enable('pyright')

        -- clangd
        vim.lsp.config('clangd', {
            on_attach = on_attach,
            capabilities = capabilities,
        })
        vim.lsp.enable('clangd')

        -- rust_analyzer
        vim.lsp.config('rust_analyzer', {
            on_attach = on_attach,
            capabilities = capabilities,
            settings = {
                ['rust-analyzer'] = {
                    diagnostics = true
                }
            }
        })
        vim.lsp.enable('rust_analyzer')
    end
}
