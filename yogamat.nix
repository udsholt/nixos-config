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

        ./container/nsq.nix
        ./container/database.nix
    ];
}
