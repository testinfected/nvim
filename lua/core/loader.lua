--[[
  Description: Bootstraps lazy.nvim plugin manager
  See: https://github.com/folke/lazy.nvim
]]

-- Builtin plugins we don't want
local disabled_builtins = {
  'netrw',
  'netrwPlugin', -- Handles file transfers and remote directory listing across a network
  'netrwSettings',
  'netrwFileHandlers',
  'gzip', -- Plugin for editing compressed files.
  'zip',
  'zipPlugin', -- Handles browsing zipfiles
  'tar',
  'tarPlugin', -- Plugin for browsing tar files
  'getscript',
  'getscriptPlugin',
  'vimball',
  'vimballPlugin',
  '2html_plugin',
  'logipat',
  'rrhelper',
  'spellfile_plugin',
  'matchparen', -- Plugin for showing matching parens
  'matchit', -- we'll get it ourselves if needed
  'tohtml', -- Converting a syntax highlighted file to HTML
  'tutor', -- Teaching
}

local bootstrap = function()
  local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
  if not vim.loop.fs_stat(lazypath) then
    vim.fn.system {
      'git',
      'clone',
      '--filter=blob:none',
      'https://github.com/folke/lazy.nvim.git',
      '--branch=stable', -- latest stable release
      lazypath,
    }
  end
  vim.opt.rtp:prepend(lazypath)

  return require('lazy')
end

local function modules_specs(modules)
  specs = {}

  for _, module in ipairs(modules) do
    table.insert(specs, { import = 'modules.' .. module })
  end

  return specs
end

local Lazy = {
  load = function(modules)
    local lazy = bootstrap()

    lazy.setup(modules_specs(modules), {
      defaults = {
        lazy = true
      },
      ui = {
        border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
        size = { width = 0.7, height = 0.7 },
        wrap = 'true'
      },
      change_detection = {
        enabled = true
      },
      debug = false,
      install = {
        colorscheme = {
          require('modules.ui.colorscheme').name
        }
      },
      performance = {
        rtp = {
          disabled_plugins = disabled_builtins
        }
      }
    })
  end
}

-- Might as well set up an easy-access keybinding
vim.keymap.set('n', '<leader>p', [[<Cmd>Lazy<CR>]], { desc = "Plugin Manager" })

return Lazy

-- vim:tabstop=2 shiftwidth=2 expandtab syntax=lua foldmethod=marker foldlevelstart=0 foldlevel=0