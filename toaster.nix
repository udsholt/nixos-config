{ config, pkgs, ... }:

{
    require = [
        ./system/toaster.nix

        ./common/user.nix
        ./common/base.nix
        ./common/desktop.nix
        ./common/i3.nix
        ./common/networkmanager.nix
        ./common/golang.nix
        ./common/node.nix
        ./common/steam.nix

        ./container/redis.nix
    ];

    environment.systemPackages = with pkgs; [
        xlibs.xbacklight

        pkgs.xscreensaver
        pkgs.gnumake
        pkgs.awscli
        pkgs.cqlsh
        pkgs.redis # for cli

        pkgs.sql-workbench

        pkgs.python
        pkgs.gcc

        #pkgs.dropbox
        #pkgs.gqview
        #pkgs.glsl-debugger
        #pkgs.apitrace
        #pkgs.libreoffice
        #pkgs.gpicview
        #pkgs.kdbg
        #pkgs.flatcc
    ];
}
