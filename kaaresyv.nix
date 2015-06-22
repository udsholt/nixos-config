{ config, pkgs, ... }:

{
    require = [
        ./system/kaaresyv.nix

        ./common/user.nix
        ./common/base.nix
        ./common/i3.nix
        ./common/golang.nix
        ./common/networkmanager.nix
        ./common/vagrant.nix
        ./common/steam.nix
        ./common/plex.nix
        ./common/dnsmasq.nix
        ./common/pco.nix

        ./container/nsq.nix
        ./container/database.nix
    ];
}
