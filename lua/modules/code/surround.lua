--[[
  Description: Add/change/delete surrounding delimiter pairs with ease
  See: https://github.com/kylechui/nvim-surround
]]

local M = {
    'kylechui/nvim-surround',
    event = 'VeryLazy',
}

M.config = function()
    require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
    })
end

return M
