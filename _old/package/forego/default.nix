{ stdenv, lib, go, fetchFromGitHub }:

stdenv.mkDerivation rec {
    name = "forego";

    src = import ./deps.nix {
        inherit stdenv lib fetchFromGitHub;
    };

    buildInputs = [ go ];

    buildPhase = ''
        export GOPATH=$src
        go build -v -o forego github.com/ddollar/forego
    '';

    installPhase = ''
        mkdir -p $out/bin
        mv forego $out/bin
    '';

    meta = with lib; {
        description = "Foreman in Go";
        homepage = "https://github.com/ddollar/forego";
        platforms = platforms.unix;
    };
}
