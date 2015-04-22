{ stdenv, lib, go, fetchFromGitHub }:

stdenv.mkDerivation rec {
  name = "gorerun";

  src = import ./deps.nix {
    inherit stdenv lib fetchFromGitHub;
  };

  buildInputs = [ go ];

  buildPhase = ''
    export GOPATH=$src
    go build -v -o rerun github.com/skelterjohn/rerun
  '';

  installPhase = ''
    mkdir -p $out/bin
    mv rerun $out/bin
  '';

  meta = with lib; {
    description = "Will autobuild and kill/relaunch the target when you update the code.";
    homepage = https://github.com/skelterjohn/rerun;
    platforms = platforms.unix;
  };
}
