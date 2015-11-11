{ config, pkgs, ... }:

{
    require = [
        ./system/yogamat.nix

        ./common/user.nix
        ./common/base.nix
        ./common/networkmanager.nix
        ./common/i3.nix
        ./common/dnsmasq.nix
        ./common/golang.nix
        ./common/nodejs.nix
        ./common/pco.nix
        ./common/cpp.nix
        #./common/firefox.nix
        #./common/vagrant.nix
        #./common/steam.nix

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
