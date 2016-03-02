{ config, pkgs, ... }:

{
    require = [
        ./system/toaster.nix

        ./common/user.nix
        ./common/base.nix
        ./common/desktop.nix
        ./common/i3.nix
        ./common/networkmanager.nix
        ./common/steam.nix
        ./common/golang.nix
        ./common/cpp.nix
        # ./common/pco.nix
        ./common/dnsmasq.nix
        ./common/nodejs.nix

        ./container/database.nix
    ];

    environment.systemPackages = with pkgs; [
        xlibs.xbacklight

        # moonlight
        # rustNightly
        # cargoNightly
    ];
}
