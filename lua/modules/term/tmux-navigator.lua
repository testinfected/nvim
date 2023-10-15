--[[
  File: tmux-navigatro.lua
  Description: Seamless navigation between tmux panes and vim splits
  See: https://github.com/goolord/alpha-nvim
]]

return {
  'christoomey/vim-tmux-navigator',
  event = 'VeryLazy',
  init = function()
    -- Disable tmux navigator when zooming the Vim pane
    vim.g.tmux_navigator_disable_when_zoomed = 1
  end
}
