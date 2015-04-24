{ config, pkgs, ... }:

{
    require = [
        ./system/kaaresyv.nix
        
        ./common/user.nix
        ./common/base.nix
        ./common/i3.nix
        ./common/golang.nix

        ./container/redis.nix
        ./container/nsq.nix
    ];
}
