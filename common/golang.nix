{ pkgs, ... }:

{
    # I have dropped mainting vscode-go dependencies, it seems by far the easiest solution is
    # to set "go.toolsGopath" in user settings and simply let vscode install all the packages
    # it wants to.

    # Current default go version is 1.11, which should not be overriden because it messses with other packages
    # Instead install go 1.12 for and setup environment for development

    environment.systemPackages = with pkgs; [
        go_1_12
        gcc
    ];

    environment.variables = {
        GOROOT = [ "${pkgs.go_1_12.out}/share/go" ]; # seems to be necessary for now
        GO111MODULE= "on";
        GOFLAGS="-mod=vendor";
    };
}

