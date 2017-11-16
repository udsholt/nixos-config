{ stdenv, lib, go, fetchFromGitHub, fetchgit }:

stdenv.mkDerivation rec {
  name = "gostatus";

  src = import ./deps.nix {
    inherit stdenv lib fetchFromGitHub fetchgit;
  };

  buildInputs = [ go ];

  buildPhase = ''
    export GOPATH=$src
    go build -v -o gostatus github.com/shurcooL/gostatus
  '';

  installPhase = ''
    mkdir -p $out/bin
    mv gostatus $out/bin
  '';

  meta = with lib; {
    description = "A command line tool, shows the status of repositories that contain Go packages.";
    homepage = https://github.com/shurcooL/gostatus;
    platforms = platforms.unix;
  };
}
