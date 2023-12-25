inputs: { lib, pkgs, config, ... }:
with lib;

let
  cfg = config.colorschemes.tokyonight;
  inherit (cfg) variant;
  tk = inputs.tokyonight;

in {
  options.colorschemes.tokyonight = {

    enable =
      mkEnableOption "tokyonight colorscheme for neovim, kitty, fish and tmux";

    variant = mkOption {
      default = "storm";
      example = ''
        "storm", "day", "moon" or "night"
      '';
    };

  };

  config = mkIf cfg.enable {

    programs = {

      kitty.extraConfig = ''
        include ${tk}/extras/kitty/tokyonight_${variant}.conf
      '';

      tmux.extraConfig =
        builtins.readFile "${tk}/extrax/tmux/tokyonight_${variant}.tmux";

      fish.plugins = [{
        name = "tokyonight-fish";
        inherit (tk) src;
      }];

      neovim.plugins = [ pkgs.vimPlugins.tokyonight-nvim ];

      neovim.extraLuaConfig = ''
        vim.cmd.colorscheme("tokyonight-${variant}")
      '';
    };

  };
}
