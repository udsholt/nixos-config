{ config, pkgs, ... }:

{
    require = [
        ./system/barnacle.nix

        ./common/user.nix
        ./common/base.nix
        ./common/desktop.nix
        ./common/i3.nix
        ./common/golang.nix
        #./common/networkmanager.nix
        #./common/steam.nix
        #./common/plex.nix
        #./common/dnsmasq.nix
        #./common/pco.nix
        #./common/nodejs.nix
        #./common/cpp.nix

        #./container/nsq.nix
        #./container/database.nix
    ];

    environment.systemPackages = with pkgs; [
      pkgs.vscode
      pkgs.awscli
      pkgs.cqlsh

       # pkgs.filezilla
       # pkgs.ffmpeg
       # pkgs.unrar
       # pkgs.kdbg
       # pkgs.valgrind
       # pkgs.apitrace
    ];
}
