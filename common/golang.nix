{ pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        go
        gotools
        go2nix

        # Setup tools for vscode-go
        # https://github.com/Microsoft/vscode-go/wiki/Go-tools-that-the-Go-extension-depends-on
        gooutline    # custom
        gosymbols    # custom
        gocode       # nixpkgs
        godef        # nixpkgs
        #godoc       # tools
        gogetdoc     # custom
        golint       # nixpkgs
        gomodifytags # custom
        gopkgs       # custom
        #gorename    # tools
        goreturns    # custom
        gotests      # custom
        #goguru      # tools
        goimpl       # custom
        delve        # nixpkgs


        # Setup tools that are nice to have
        gorerun      # custom
        goforego     # custom
        dep          # nixpkgs
        govendor     # custom
        gotorch      # custom
        gomplate     # custom
    ];

    environment.variables = {
        GOROOT = [ "${pkgs.go.out}/share/go" ];
    };
}

