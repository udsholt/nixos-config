{ config, pkgs, ... }:

{
    require = [
        ./system/toaster.nix
        
        ./common/user.nix
        ./common/base.nix
        ./common/networkmanager.nix
        ./common/i3.nix
        ./common/steam.nix
        ./common/golang.nix
        ./common/cpp.nix
    ];

    environment.systemPackages = with pkgs; [
        xlibs.xbacklight
        mlt-swf
    ];
}
