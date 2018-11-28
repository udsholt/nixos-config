{ pkgs, ... }:

{

    # I have dropped mainting vscode-go dependencies, it seems by far the easiest solution is
    # to set "go.toolsGopath" in user settings and simply let vscode install all the packages
    # it wants to.

    environment.systemPackages = with pkgs; [
        go
        gotools
        dep
        delve
        gcc
    ];

    environment.variables = {
        GOROOT = [ "${pkgs.go.out}/share/go" ];
    };
}

