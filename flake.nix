{
  description = "Nix flake for the popular `tokyonight` colorscheme";
  inputs.tokyonight = {
    type = "github";
    owner = "folke";
    repo = "tokyonight.nvim";
    flake = false;
  };

  outputs = inputs@{ self }: {
    homeModules = { colorscheme = import ./colorscheme inputs; };
  };
}

