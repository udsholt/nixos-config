{ config, pkgs, ... }:

{
    require = [
        ./system/yogamat.nix
        
        ./common/user.nix
        ./common/base.nix
        ./common/i3.nix
        ./common/golang.nix
        ./common/supplicant.nix
        ./common/vagrant.nix
        ./common/dnsmasq.nix
        ./common/pco.nix
        
        ./container/nsq.nix
        ./container/database.nix
    ];

    environment.systemPackages = with pkgs; [
        sshfsFuse
        openvpn
    ];
}
