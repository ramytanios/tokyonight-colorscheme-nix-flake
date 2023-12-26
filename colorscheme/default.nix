inputs:
{ lib, pkgs, config, ... }:
with lib;

let
  cfg = config.colorscheme.tokyonight;
  inherit (cfg) style;
  tk = inputs.tokyonight;
  styles = [ "day" "moon" "night" "storm" ];

in {
  options.colorscheme.tokyonight = {

    enable =
      mkEnableOption "tokyonight colorscheme for neovim, kitty, fish and tmux";

    extraLua = mkOption {
      type = types.lines;
      default = "";
      example = ''
          require("tokyonight").setup({
          -- disable italic for functions
          styles = {
            functions = {}
          }
        })
      '';
      description = "Extra lua configuration for the colorscheme.";
    };

    style = mkOption {
      default = "storm";
      type = types.enum (styles);
      example = ''
        "storm", "day", "moon" or "night"
      '';
      description = "Tokyonight style";
    };

  };

  config = mkIf cfg.enable {

    programs = {

      kitty.extraConfig = ''
        include ${tk}/extras/kitty/tokyonight_${style}.conf;
      '';

      tmux.extraConfig =
        builtins.readFile "${tk}/extras/tmux/tokyonight_${style}.tmux";

      fish.interactiveShellInit =
        builtins.readFile "${tk}/extras/fish/tokyonight_${style}.fish";

      neovim.plugins = [ pkgs.vimPlugins.tokyonight-nvim ];

      neovim.extraLuaConfig = ''
        ${cfg.extraLua}
        vim.cmd.colorscheme("tokyonight-${style}")
      '';
    };

  };
}
