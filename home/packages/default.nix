{ pkgs, lib, config, ... }:

let
  cfg = config.packages;
in {
  options = {
    packages.officeApps = 
      lib.mkEnableOption "Installs libreoffice suite";
    packages.chatApps = 
      lib.mkEnableOption "Installs chat apps such as Discord";
    packages.shellPlugins = 
      lib.mkEnableOption "Installs oh my zsh, among others";
  };
 
  config = {
    packages.officeApps = lib.mkDefault true;
    packages.chatApps = lib.mkDefault true;

    home.packages = lib.mkMerge [
      (lib.mkIf cfg.officeApps [ pkgs.libreoffice ])
      (lib.mkIf cfg.chatApps [ pkgs.discord pkgs.discordo ])
      (lib.mkIf cfg.shellPlugins [ pks.oh-my-zsh ])
    ];
  };
}
