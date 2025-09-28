return {
    "mrcjkb/rustaceanvim",
    version = "^6", -- Recommended
    lazy = false, -- This plugin is already lazy
    config = function()
        vim.g.rustaceanvim = {
            server = {
                on_attach = function(_, bufnr)
                    vim.keymap.set("n", "<leader>ca", function()
                        vim.cmd.RustLsp("codeAction")
                    end, { desc = "Code Action", buffer = bufnr })
                    vim.keymap.set("n", "<leader>cl", function()
                        vim.lsp.codelens.run()
                    end, { desc = "Code Lens", buffer = bufnr })
                    vim.keymap.set("n", "<leader>dr", function()
                        vim.cmd.RustLsp("debuggables")
                    end, { desc = "Rust Debuggables", buffer = bufnr })
                    vim.keymap.set("n", "K", function()
                        vim.cmd.RustLsp({ "hover", "actions" })
                    end, { silent = true, buffer = bufnr })
                    vim.keymap.set("n", "gd", function()
                        require("navigator.definition").definition()
                    end, { desc = "Definition", buffer = bufnr })
                    vim.keymap.set("n", "gr", function()
                        require("navigator.reference").async_ref()
                    end, { desc = "Reference", buffer = bufnr })
                    vim.keymap.set("n", "<leader>cf", function()
                        vim.lsp.buf.format()
                    end, { desc = "Format", buffer = bufnr })
                    vim.keymap.set("v", "<leader>cf", function()
                        require("navigator.formatting").range_format()
                    end, { desc = "Format Selected", buffer = bufnr })
                    vim.keymap.set("n", "<leader>cr", function()
                        require("navigator.rename").rename()
                    end, { desc = "Rename", buffer = bufnr })
                end,
                default_settings = {
                    -- rust-analyzer language server configuration
                    ["rust-analyzer"] = {
                        cargo = {
                            allFeatures = true,
                            loadOutDirsFromCheck = true,
                            buildScripts = {
                                enable = true,
                            },
                        },
                        -- Add clippy lints for Rust if using rust-analyzer
                        checkOnSave = true,
                        -- Enable diagnostics if using rust-analyzer
                        diagnostics = {
                            enable = true,
                        },
                        procMacro = {
                            enable = true,
                            ignored = {
                                ["async-trait"] = { "async_trait" },
                                ["napi-derive"] = { "napi" },
                                ["async-recursion"] = { "async_recursion" },
                            },
                        },
                    },
                },
            },
            tools = {
                float_win_config = {
                    border = "rounded",
                },
            },
        }
    end,
}
