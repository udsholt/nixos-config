{ config, pkgs, ... }:

{
    require = [
        ./system/yogamat.nix

        ./common/user.nix
        ./common/base.nix
        ./common/i3.nix
        ./common/golang.nix
        ./common/nodejs.nix
        ./common/networkmanager.nix
        ./common/vagrant.nix
        ./common/dnsmasq.nix
        ./common/pco.nix
        ./common/firefox.nix

        ./container/nsq.nix
        ./container/database.nix
        ./container/redis.nix
        ./container/disque.nix
        ./container/elasticsearch.nix
    ];

    environment.systemPackages = with pkgs; [
        sshfsFuse
        openvpn
        xlibs.xbacklight
    ];
}
