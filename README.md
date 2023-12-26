# tokyonight-colorscheme-nix-flake
The popular colorscheme [Tokyo night](https://github.com/folke/tokyonight.nvim)
distributed as a nix flake exposing a [home-manager](https://github.com/nix-community/home-manager) module.

Currently supports only neovim, kitty, fish shell and tmux.

* Import `homeModules.colorscheme` as a home-manager module.
* Activate colorscheme `colorscheme.tokyonight.enable = true`.
* Choose a style `colorscheme.tokyonight.style = "moon"`. Default is `storm`. 
* Optionally add extra lua config with `colorscheme.tokyonight.extraLua = ...`.
