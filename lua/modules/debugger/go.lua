--[[
  Description: DAP extension for delve (go debugger)
  See: https://github.com/leoluz/nvim-dap-go
]]

local M = {
        "leoluz/nvim-dap-go",
}

function M.config()
    require('dap-go').setup({

    })
end

return M