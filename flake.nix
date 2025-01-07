{
  description = "Nix flake for the popular `tokyonight` colorscheme";

  inputs.tokyonight.url = "github:folke/tokyonight.nvim";
  inputs.tokyonight.flake = false;

  outputs = inputs: {
    homeModules.colorscheme = import ./colorscheme inputs;
  };
}
