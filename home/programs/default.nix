{ pkgs, lib, config, ... }:

let
  cfg = config.programs.custom;
in {
  options = {
    programs.custom.firefox = lib.mkEnableOption "Enables firefox";
    programs.custom.zsh = lib.mkEnableOption "Enables my custom zsh setup";
    programs.custom.git = lib.mkEnableOption "Enables git with me as the user";
    programs.custom.nvim = lib.mkEnableOption "Enables my NeoVim setup"
  }

  config = {
    programs.custom.firefox = mkDefault true;
    programs.custom.zsh = mkDefault true;
    programs.custom.git = mkDefault true;
    programs.custom.nvim = mkDefault true;

    programs.zsh = (lib.mkIf programs.custom.zsh) {
      enable = true;
      enableCompletion = true
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;

      shellAliases = {
        ll = "ls -lah";
        edit = "sudo -e";
        update = "sudo nixos-rebuild switch";
        nvim = "vi";
        nvim = "vim";
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

    programs.git = (lib.mkIf programs.custom.git) {
      enable = true;
      package = pkgs.gitFull;
      settings = {
        name = "DJamesV";
        email = "djames.veenstra@gmail.com";
      }
    };

    programs.nvim = (lib.mkIf programs.custom.nvim) {
      enable = true;
    };

    # NOTE: This is an unfree package. Unfortunately, I cannot build the free version myself.
    programs.firefox = {
      enable = true;
      package = pkgs.firefox-bin;
    };

  };
}
