{ stdenv, lib, go, fetchFromGitHub }:

stdenv.mkDerivation rec {
    name = "sift";

    src = import ./deps.nix {
        inherit stdenv lib fetchFromGitHub;
    };

    buildInputs = [ go ];

    buildPhase = ''
        export GOPATH=$src
        go build -v -o sift github.com/svent/sift
    '';

    installPhase = ''
        mkdir -p $out/bin
        mv sift $out/bin
    '';

    meta = with lib; {
        description = "sift is a fast and powerful open source alternative to grep.";
        homepage = https://sift-tool.org/;
        platforms = platforms.unix;
    };
}
