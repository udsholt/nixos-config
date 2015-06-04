# i3 desktop config
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
