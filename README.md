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

- [NPM](https://nodejs.org)
- [Fzf](https://github.com/junegunn/fzf)
- [Sad](https://github.com/ms-jpq/sad)
- [LazyGit](https://github.com/jesseduffield/lazygit)
- [Delta](https://github.com/pocco81/true-zen.nvim)
- [RipGrep](https://github.com/BurntSushi/ripgrep)

## Plugin Management

- [lazy-nvim](https://github.com/folke/lazy.nvim)

## Code

- [nvim-autopair](https://github.com/windwp/nvim-autopair): Autopairs with support for multiple chars
- [nvim-ts-autotag](https://github.com/windwp/nvim-ts-autotag): Autoclose and autorename tags
- [nvim-colorizer](https://github.com/NvChad/nvim-colorizer.lua): Color highlighter
- [Comment](https://github.com/numToStr/Comment.nvim): Operator to toggle comments
- [rainbow-delimiters](https://github.com/HiPhish/rainbow-delimiters.nvim): Rainbow delimiters using treesitter
- [nvim-treesitter-context](https://github.com/nvim-treesitter/nvim-treesitter-context): Code context
- [trouble.nvim](https://github.com/folke/trouble.nvim): Pretty diagnostics
- [gitsigns](https://github.com/lewis6991/gitsigns.nvim): Git gutter decorations
- [vim-illuminate](https://github.com/RRethy/vim-illuminate): Automatic highlighting of word under cursor
- [indent-blankline](https://github.com/lukas-reineke/indent-blankline.nvim): Ident guides
- [neotest](https://github.com/nvim-neotest/neotest): Framework for interacting with tests
- [nvim-surround](https://github.com/kylechui/nvim-surround): Surrounding delimiters with ease

## Completion

- [nvim-cmp](https://github.com/hrsh7th/nvim-cmp): Completion engine

## Debugger

- [nvim-dap](https://github.com/mfussenegger/nvim-dap): Debug adapter protocol client
- [nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui): UI for nvim-dap
- [mason-nvim-dap](https://github.com/jay-babu/mason-nvim-dap.nvim): Install debug adapters with Mason
- [cmp-dap](https://github.com/rcarriga/cmp-dap): Completion source for nvim-dap

## Editor

- [vim-abolish](https://github.com/tpope/vim-abolish): Work with variants of a word
- [better-escape](https://github.com/max397574/better-escape.nvim): Quick escape from insert mode
- [beacon](https://github.com/DanilaMihailov/beacon.nvim): Flash cursor on jump
- [nvim-ufo](https://github.com/kevinhwang91/nvim-ufo): Modern looking folds
- [range-highlight](https://github.com/rktjmp/winston0410/range-highlight.nvim): Automatically highlight ranges
- [relative-toggle](https://github.com/cpea2506/relative-toggle.nvim): Automatic toggle to relative line numbers
- [vim-repeat](https://github.com/tpope/vim-repeat): Extended usage of repeat (.) command
- [sad](https://github.com/ray-x/sad.nvim): Search and replace
- [unimpaired](https://github.com/tummetott/unimpaired.nvim): Pairs of useful mappings

## Lang

- [hotpot](https://github.com/rktjmp/hotpot.nvim): Hotpot fennel compiler
- [go](https://github.com/ray-x/go.nvim): Golang plugin
- [glow](https://github.com/ellisonleao/glow.nvim): Markdown previewer

## Lsp

- [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig): Quickstart LSP configs
- [lspsaga](https://github.com/nvimdev/lspsaga.nvim): Improved LSP experience
- [null-ls](https://github.com/jose-elias-alvarez/null-ls.nvim): Inject LSP diagnostics
- [lspkind](https://github.com/onsails/lspkind.nvim): Icons for completion menu

## Term

- [toggleterm](https://github.com/akinsho/toggleterm.nvim): Terminal window
- [vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator): Seamless navigation between tmxux and neovim

## Tools

- [telescope](https://github.com/nvim-telescope/telescope.nvim): Fuzzy finder
- [telescope-file-browser](https://github.com/nvim-telescope/telescope-file-browser.nvim): Filebrowser extension for Telescope
- [tree-sitter](https://github.com/tree-sitter/tree-sitter): Syntax highlighter
- [targets](https://github.com/wellle/targets.vim): Additional targets from text objects
- [nvim-tree](https://github.com/nvim-tree/nvim-tree.nvim): File explorer
- [project](https://github.com/ahmedkhalf/project.nvim): Project management
- [persisted](https://github.com/olimorris/persisted.nvim): Automated session management
- [mason](https://github.com/williamboman/mason.nvim): Package manager for lsp and dap servers
- [overseer](https://github.com/stevearc/overseer.nvim): Task runner and job manager

## UI

- [catppuccin](https://github.com/catppuccin/nvim): Catppuccin theme
- [alpha](https://github.com/goolord/alpha-nvim): Start screen
- [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons): Additional icons
- [dressing](https://github.com/stevearc/dressing.nvim): Improved vim.ui interfaces
- [statuscol](https://github.com/luukvbaal/statuscol.nvim): Configurable status column with click handlers
- [which-key](https://github.com/folke/which-key.nvim): Keymap help
- [notifier](https://github.com/vigoux/notifier.nvim): Non intrusive notification system
- [noice](https://github.com/folke/noice.nvim): Replacement for command line
- [lualine](https://github.com/nvim-lualine/lualine.nvim): Configurable statusline
- [nvim-pqf](https://github.com/yorickpeterse/nvim-pqf): Prettier QuickFix list
- [bufferline](https://github.com/akinsho/bufferline.nvim): Snazzy bufferline  
- [true-zen](https://github.com/pocco81/true-zen.nvim): Distraction free coding
