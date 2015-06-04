{ config, pkgs, ... }:

{
    require = [
        ./system/kaaresyv.nix
        
        ./common/user.nix
        ./common/base.nix
        ./common/i3.nix
        ./common/golang.nix
        ./common/vagrant.nix
        ./common/steam.nix
        ./common/plex.nix

        ./container/nsq.nix
        ./container/database.nix
    ];
}
