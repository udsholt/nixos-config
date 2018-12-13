{
  stdenv, fetchFromGitHub, libX11
}:

stdenv.mkDerivation rec {
  name = "xeventbind-${version}";
  version = "dev";

  src = fetchFromGitHub {
    owner  = "ritave";
    repo   = "xeventbind";
    rev    = "a0b00eda640520c2df1bcc0380c7fa575e1a982f";
    sha256 = "1yjhqnyd66ayy4g5ymx82h36pvg35hjzhb18g059zfgyl181vv91";
  };

  buildInputs = [ libX11 ];

  installPhase = ''
    mkdir -p $out/bin
    cp xeventbind $out/bin/xeventbind
  '';
}
