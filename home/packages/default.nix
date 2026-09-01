{ pkgs, lib, config, ... }:

let
  cfg = config.packages;
in {
  options = {
    packages.officeApps = 
      lib.mkEnableOption "Installs libreoffice suite";
    packages.chatApps = 
      lib.mkEnableOption "Installs chat apps such as Discord";
  };
  
  config = with lib; {
    packages.officeApps = mkDefault true;
    packages.chatApps = mkDefault true;

    home.packages = mkMerge [
      (mkIf cfg.officeApps [ pkgs.libreoffice ])
      (mkIf cfg.chatApps [ pkgs.discord pkgs.discordo ])
    ];
  };
}
    
    
