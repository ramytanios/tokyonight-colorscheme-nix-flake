inputs:
{ lib, pkgs, config, ... }:
with lib;

let
  cfg = config.colorscheme.tokyonight;
  isFish = cfg.fish.enable;
  isKitty = cfg.kitty.enable;
  isTmux = cfg.tmux.enable;
  isNeovim = cfg.neovim.enable;
  inherit (cfg) style;
  tk = inputs.tokyonight;
  styles = [ "day" "moon" "night" "storm" ];

in {
  options.colorscheme.tokyonight = {

    style = mkOption {
      default = "storm";
      type = types.enum styles;
      example = ''
        "storm", "day", "moon" or "night"
      '';
      description = "Tokyonight style";
    };

    fish.enable =
      mkEnableOption "Whether to enable Tokyonight colorscheme for Fish";
    kitty.enable =
      mkEnableOption "Whether to enable Tokyonight colorscheme for Kitty";
    tmux.enable =
      mkEnableOption "Whether to enable Tokyonight colorscheme for Tmux";
    neovim.enable =
      mkEnableOption "Whether to enable the Tokyonight colorscheme for Neovim";
    neovim.extraLua = mkOption {
      type = types.lines;
      default = ''
        require("tokyonight").setup({})
      '';
      example = ''
          require("tokyonight").setup({
          -- disable italic for functions
          styles = {
            functions = {}
          }
        })
      '';
      description = "Extra lua configuration for the Tokyonight colorscheme.";
    };

  };

  config = mkMerge [
    (mkIf isKitty {
      programs.kitty.extraConfig = ''
        include ${tk}/extras/kitty/tokyonight_${style}.conf;
      '';
    })
    (mkIf isFish {
      programs.fish.interactiveShellInit =
        builtins.readFile "${tk}/extras/fish/tokyonight_${style}.fish";
    })
    (mkIf isTmux {
      programs.tmux.extraConfig =
        builtins.readFile "${tk}/extras/tmux/tokyonight_${style}.tmux";
    })
    (mkIf isNeovim {
      programs.neovim.plugins = [ pkgs.vimPlugins.tokyonight-nvim ];
      programs.neovim.extraLuaConfig = ''
        ${cfg.extraLua}
        vim.cmd.colorscheme("tokyonight-${style}")
      '';
    })
  ];
}

