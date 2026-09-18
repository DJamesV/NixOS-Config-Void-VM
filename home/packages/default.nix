{ pkgs, lib, config, ... }:

let
  cfg = config.packages;
in {
  options = {
    packages.officeApps = 
      lib.mkEnableOption "Installs libreoffice suite";
    packages.chatApps = 
      lib.mkEnableOption "Installs chat apps such as Discord";
    packages.softwareUtils = 
      lib.mkEnableOption "Installs programming tools such as cargo, gcc, and python3";
    packages.programmingTools = 
      lib.mkEnableOption "Installs lazygit and yazi";
  };
 
  config = {
    packages.officeApps = lib.mkDefault true;
    packages.chatApps = lib.mkDefault true;
    packages.softwareUtils = lib.mkDefault true;
    packages.programmingTools = lib.mkDefault true;

    home.packages = lib.mkMerge [
      (lib.mkIf cfg.officeApps [ pkgs.libreoffice ])
      (lib.mkIf cfg.chatApps [ pkgs.discord pkgs.concord-tui ])
      (lib.mkIf cfg.softwareUtils (with pkgs; [
        unzip
        gzip
        gnutar
        nodejs
        python3
        cargo
        gcc
        gnumake
        cmake
        binutils
      ]))
      (lib.mkIf cfg.programmingTools [ pkgs.lazygit pkgs.yazi ])
    ];
  };
}
