{ config, pkgs, ... }:

{
    require = [
        ./system/zenfoot.nix

        ./common/user.nix
        ./common/base.nix
        ./common/desktop.nix
        ./common/i3.nix
        ./common/networkmanager.nix
        ./common/steam.nix
        ./common/golang.nix
        ./common/nodejs.nix
    ];
}
