--[[
  File: go.lua
  Description: Feature-rich Go development plugin
  See: https://github.com/ray-x/go.nvim
]]

local M = {
    'ray-x/go.nvim',
    dependencies = {
        'ray-x/guihua.lua',
        'neovim/nvim-lspconfig',
    },
    ft = { 'go', 'gomod' },
    build = [[:lua require('go.install').update_all_sync()]] -- if you need to install/update all binaries
}

function M.config()
    -- TODO:
    -- [] configure test coverage
    -- [] configure symbols outline
    -- [] use lsp snippets from go.nvim
    -- [] integrate null-ls
    -- [] add buffer key mappings for test, etc.

    -- [] add https://github.com/jeniasaigak/goplay.nvim plugin
    -- [] consider https://github.com/ray-x/navigator.lua plugin

    require('go').setup {
        icons = false,             -- We have already setup dap icons so don't want them overridden here
        lsp_cfg = false,           -- Use mason, then apply gopls config after setup
        lsp_keymaps = false,
        lsp_diag_virtual_text = false, -- Set up as part of diagnostics
        dap_debug_keymap = false,  -- I have set this up already with all my other nvim-dap setup
        textobjects = false,       -- Already have textobjects set up so do not add a mapping for this
        run_in_floaterm = true,
        -- TODO: make this a project specific setup, rather than a global setup
        test_runner = 'ginkgo',
        trouble = true,
        lua_snip = true,
    }

    -- Use go.nvim gopls config with lsp
    local cfg = require('go.lsp').config()
    require('lspconfig').gopls.setup(cfg)

    local null_ls = require("null-ls")
    local sources = {
        null_ls.builtins.diagnostics.revive,
        null_ls.builtins.formatting.golines.with({
            extra_args = {
                "--max-len=120",
                "--base-formatter=gofumpt",
            },
        })
    }
    -- for go.nvim
    local gotest = require("go.null_ls").gotest()
    local gotest_codeaction = require("go.null_ls").gotest_action()
    local golangci_lint = require("go.null_ls").golangci_lint()
    table.insert(sources, gotest)
    table.insert(sources, golangci_lint)
    table.insert(sources, gotest_codeaction)
    null_ls.setup({ sources = sources, debounce = 1000, default_timeout = 5000 })

    -- alternatively
    --null_ls.register(gotest)

    -- Run gofmt on save
    local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
    vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*.go",
        callback = function()
            require('go.format').gofmt()
        end,
        group = format_sync_grp,
    })
end

return M
