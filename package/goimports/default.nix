{ stdenv, lib, go, fetchFromGitHub }:

stdenv.mkDerivation rec {
  name = "goimports";

  src = import ./deps.nix {
    inherit stdenv lib fetchFromGitHub;
  };

  buildInputs = [ go ];

  buildPhase = ''
    export GOPATH=$src
    go build -v -o goimports golang.org/x/tools/cmd/goimports
  '';

  installPhase = ''
    mkdir -p $out/bin
    mv goimports $out/bin
  '';

  meta = with lib; {
    description = "Updates your Go import lines, adding missing ones and removing unreferenced ones.";
    homepage = https://godoc.org/golang.org/x/tools/cmd/goimports;
    platforms = platforms.unix;
  };
}
