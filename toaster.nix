{ config, pkgs, ... }:

{
    require = [
        ./system/toaster.nix
        
        ./common/user.nix
        ./common/base.nix
        ./common/networkmanager.nix
        ./common/i3.nix
        ./common/steam.nix
    ];

    environment.systemPackages = with pkgs; [
        xlibs.xbacklight
    ];
}
