{
  stdenv,
  fetchurl,
  python,
  makeWrapper
}:

stdenv.mkDerivation rec {
  name = "cqlsh-${version}";
  version = "3.11.0";

  src = fetchurl {
    url = "mirror://apache/cassandra/${version}/apache-cassandra-${version}-bin.tar.gz";
    sha256 = "19sgsi0l1fh4v40dd0zxjfwaqh43wnwrsl9ka29czlib82dvk5ym";
  };

  phases = [ "unpackPhase" "installPhase" ];

  nativeBuildInputs = [ makeWrapper ];

  installPhase = ''
    mkdir $out
    mv * $out

    mv $out/bin $out/_bin

    mkdir -p $out/bin
    mv $out/_bin/cqlsh $out/bin/cqlsh
    mv $out/_bin/cqlsh.py $out/bin/cqlsh.py

    rm -rf $out/_bin

    wrapProgram $out/bin/cqlsh --prefix PATH : ${python}/bin
  '';
}