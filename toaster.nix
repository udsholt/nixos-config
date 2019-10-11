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
        # ./common/node.nix
        # ./common/steam.nix
        ./common/docker.nix
    ];

    environment.systemPackages = with pkgs; [
        xlibs.xbacklight
        pkgs.xscreensaver
        #pkgs.gnumake
        #pkgs.awscli
        #pkgs.cqlsh
        #pkgs.redis # for cli
        #pkgs.sql-workbench
        #pkgs.python
        #pkgs.gcc
    ];
}
