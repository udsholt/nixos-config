{ config, pkgs, ... }:

{
    require = [
        ./system/toaster.nix
        
        ./common/user.nix
        ./common/base.nix
        ./common/i3.nix
        ./common/networkmanager.nix
    ];

    environment.systemPackages = with pkgs; [
        xlibs.xbacklight
    ];
}
