{ config, pkgs, ... }:

{
    require = [
        ./system/cuttlefish.nix

        ./common/user.nix
        ./common/base.nix
        ./common/desktop.nix
        ./common/i3.nix
        ./common/sybo.nix
        ./common/node.nix
        ./common/golang.nix
    ];
}
