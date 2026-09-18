{ pkgs, lib, config, ... }:

let
  cfg = config.programs.custom;
in {
  options = {
    programs.custom.firefox = lib.mkEnableOption "Enables firefox";
    programs.custom.zsh = lib.mkEnableOption "Enables my custom zsh setup";
    programs.custom.git = lib.mkEnableOption "Enables git with me as the user";
    programs.custom.neovim = lib.mkEnableOption "Enables my NeoVim setup";
  };

  config = {
    programs.custom.firefox = lib.mkDefault true;
    programs.custom.zsh = lib.mkDefault true;
    programs.custom.git = lib.mkDefault true;
    programs.custom.neovim = lib.mkDefault true;

    programs.zsh = lib.mkIf cfg.zsh {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      shellAliases = {
        ll = "ls -lah";
        edit = "sudo -e";
        update = "sudo nixos-rebuild switch";
        sapling = "tree -L 2";
      };

      ohMyZsh = {
        enable = true;
        plugins = [
          "z"
          "git"
        ];
        theme = "agnoster";
      };
    };

    programs.git = lib.mkIf cfg.git {
      enable = true;
      package = pkgs.gitFull;
      settings = {
        user = {
	  name = "DJamesV";
	  email = "djames.veenstra@gmail.com";
        };
      };
    };

    programs.neovim = lib.mkIf cfg.neovim {
      enable = true;

      viAlias = true;
      vimAlias = true;
    };

    # NOTE: This is an unfree package. Unfortunately, I cannot build the free version myself.
    programs.firefox = lib.mkIf cfg.firefox {
      enable = true;
      package = pkgs.firefox-bin;
    };

  };
}
