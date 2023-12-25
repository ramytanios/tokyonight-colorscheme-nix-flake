inputs:
{ lib, pkgs, config, ... }:
with lib;

let
  cfg = config.colorscheme.tokyonight;
  inherit (cfg) variant;
  tk = inputs.tokyonight;
  variants = [ "day" "moon" "night" "storm" ];

in {
  options.colorscheme.tokyonight = {

    enable =
      mkEnableOption "tokyonight colorscheme for neovim, kitty, fish and tmux";

    themeExtraLua = mkOption { type = types.str; };

    variant = mkOption {
      default = "storm";
      type = types.enum (variants);
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
        builtins.readFile "${tk}/extras/tmux/tokyonight_${variant}.tmux";

      fish.interactiveShellInit =
        builtins.readFile "${tk}/extras/fish/tokyonight_{variant}.fish";

      neovim.plugins = [ pkgs.vimPlugins.tokyonight-nvim ];

      neovim.extraLuaConfig = ''
        ${cfg.themeExtraLua}
        vim.cmd.colorscheme("tokyonight-${variant}")
      '';
    };

  };
}
