{ pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        go
        godep
        gocode
        golint
        gotags
        goimports
        gorerun
        gohelpers
        gostatus
    ];
}
