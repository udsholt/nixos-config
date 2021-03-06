{ config, pkgs, ... }:

{
    require = [
        ./system/octopus.nix

        ./common/user.nix
        ./common/base.nix
        ./common/desktop.nix
        ./common/i3.nix
        ./common/node.nix
        ./common/golang.nix
        ./common/docker.nix
    ];

    environment.systemPackages = with pkgs; [
        pkgs.redis
    ];
}
