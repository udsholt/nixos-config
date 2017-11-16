{ pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        go
        #godep
        #gocode
        #golint
        #gotags
        #goimports
        #gorerun
        #gohelpers
        #gostatus
        #forego
    ];

    environment.variables = {
        GOROOT = [ "${pkgs.go.out}/share/go" ];
    };
}

