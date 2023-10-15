# About
A well structured NeoVim configuration packed with features.

This configuration can serve as a starting point if you want to build your own personal configuration. Well documented, at the top of each file you can find a frontmatter which provides information.

# Structure

```
.
├── init.lua                  -- Entry point
│
├── lua
│  ├── config                 -- User configuration
│  │  ├── options.lua         -- NeoVim options 
│  │  └── keymaps.lua         -- General keybindings
│  │  └── icons.lua           -- Icons definitions 
│  │  
│  ├── core                   -- Plugin management
│  │  ├── hotspot.lua         -- Hotpot compiler (to write your plugins in Fennel) 
│  │  └── lazy.lua            -- Plugin manager 
│  │  └── loader.lua          -- Plugin loader 
│  │  
│  ├── modules                -- Plugins organized in modules
│  │  ├── code.lua            -- Code related plugins
│  │  ├── completion.lua      -- Code completion plugins 
│  │  ├── debugger.lua        -- Debugger related plugins
│  │  ├── editor.lua          -- Plugins to enhance edition experience
│  │  ├── lang.lua            -- Programming languages specific plugins 
│  │  ├── lsp.lua             -- Language servers support 
│  │  ├── term.lua            -- Terminal plugins 
│  │  ├── tools.lua           -- Various utilities 
│  │  ├── ui.lua              -- Plugins for better user experience 
```

# Plugins

## Requirement's

The following tools are required for the plugins to work properly and provide the best experience:

* [NPM](https://nodejs.org)
* [Fzf](https://github.com/junegunn/fzf)
* [Sad](https://github.com/ms-jpq/sad)
* [LazyGit](https://github.com/jesseduffield/lazygit)
* [Delta](https://github.com/pocco81/true-zen.nvim)
* [RipGrep](https://github.com/BurntSushi/ripgrep)

## Plugin Management 
- [Lazy](https://github.com/folke/lazy.nvim)

## Code
- [Autopairs](https://github.com/windwp/nvim-autopair)
- [Autotags](https://github.com/windwp/nnvim-ts-autotag)
- [Colorizer](https://github.com/NvChad/nvim-colorizer.lua)
- [Comments](https://github.com/numToStr/Comment.nvim)
- [Rainbow delimiters](https://github.com/HiPhish/rainbow-delimiters.nvim)
- [Tree Sitter Context](https://github.com/nvim-treesitter/nvim-treesitter-context)
- [Trouble.nvim](https://github.com/folke/trouble.nvim)
- [Git Signs](https://github.com/lewis6991/gitsigns.nvim)
- [Illuminate](https://github.com/RRethy/vim-illuminate)
- [Indent blankline](https://github.com/lukas-reineke/indent-blankline.nvim)
- [Neotest](https://github.com/nvim-neotest/neotest)
- [Surround](https://github.com/kylechui/nvim-surround)

## Completion
- [Cmp](https://github.com/hrsh7th/nvim-cmp)

## Debugger
- [DAP](https://github.com/mfussenegger/nvim-dap)
- [DAP UI](https://github.com/rcarriga/nvim-dap-ui)
- [Mason DAP](https://github.com/jay-babu/mason-nvim-dap.nvim)
- [Cmp DAP](https://github.com/rcarriga/cmp-dap)

## Editor
- [Abolish](https://github.com/tpope/vim-abolish)
- [Better Escape](https://github.com/max397574/better-escape.nvim)
- [Beacon](https://github.com/DanilaMihailov/beacon.nvim)
- [UFO](https://github.com/kevinhwang91/nvim-ufo)
- [Range Highlight](https://github.com/rktjmp/winston0410/range-highlight.nvim)
- [Relavtive Toggle](https://github.com/cpea2506/relative-toggle.nvim)
- [Repeat](https://github.com/tpope/vim-repeat)
- [Sad](https://github.com/ray-x/sad.nvim)
- [Unimpaired](https://github.com/tummetott/unimpaired.nvim)

## Lang
 - [Hotpot](https://github.com/rktjmp/hotpot.nvim)
 - [Go](https://github.com/ray-x/go.nvim)
 - [Markdown](https://github.com/ellisonleao/glow.nvim)

## Lsp
 - [Lsp Config](https://github.com/neovim/nvim-lspconfig)
 - [Lsp Saga](https://github.com/neovim/nvim-lspconfig)
 - [Null-ls](https://github.com/jose-elias-alvarez/null-ls.nvim)

## Term
 - [ToggleTerm](https://github.com/akinsho/toggleterm.nvim)
 - [Tmux Navigator](https://github.com/goolord/alpha-nvim)

## Tools
- [Telescope](https://github.com/nvim-telescope/telescope.nvim)
- [Telescope FileBrowser](https://github.com/nvim-telescope/telescope-file-browser.nvim)
- [Tree Sitter](https://github.com/tree-sitter/tree-sitter)
- [Tree Sitter Targets](https://github.com/wellle/targets.vim)
- [Neo-tree](https://github.com/nvim-neo-tree/neo-tree.nvim)
- [Project](https://github.com/ahmedkhalf/project.nvim)
- [Persisted](https://github.com/olimorris/persisted.nvim)
- [Mason](https://github.com/williamboman/mason.nvim)
- [Overseer](https://github.com/stevearc/overseer.nvim)
- [Lspkind](https://github.com/onsails/lspkind.nvim)

## UI
- [Catppuccin](https://github.com/catppuccin/nvim)
- [Alpha](https://github.com/goolord/alpha-nvim)
- [Web Dev Icons](https://github.com/nvim-tree/nvim-web-devicons)
- [Dressing](https://github.com/goolord/alpha-nvim)
- [StatusCol](https://github.com/luukvbaal/statuscol.nvim)
- [Which Key](https://github.com/folke/which-key.nvim)
- [Notifier](https://github.com/vigoux/notifier.nvim)
- [Noice](https://github.com/folke/noice.nvim)
- [Lualine](https://github.com/nvim-lualine/lualine.nvim)
- [Prettier Quick Fix](https://github.com/yorickpeterse/nvim-pqf)
- [Bufferline](https://github.com/akinsho/bufferline.nvim)
- [True Zen](https://github.com/pocco81/true-zen.nvim)
