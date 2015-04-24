{ config, pkgs, ... }:

{
    require = [
        ./nsqd.nix
        ./nsqlookupd.nix
        ./nsqadmin.nix
    ];
}
