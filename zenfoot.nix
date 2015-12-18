{ config, pkgs, ... }:

{
    require = [
        ./system/zenfoot.nix

        ./common/user.nix
        ./common/base.nix
        ./common/i3.nix
        ./common/networkmanager.nix
        ./common/golang.nix
        ./common/nodejs.nix
    ];
}
