{ config, pkgs, ... }:

{
    require = [
        ./system/cuttlefish.nix

        ./common/user.nix
        ./common/base.nix
        ./common/desktop.nix
        ./common/i3.nix
    ];
}
