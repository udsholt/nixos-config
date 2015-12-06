{ stdenv, fetchurl, unzip }:

stdenv.mkDerivation rec {

  name = "font-awesome";
  version = "4.5.0";
  
  # Fetch the zip file
  # Im not entirely sure what name does here
  src = fetchurl {
    url = "https://fortawesome.github.io/Font-Awesome/assets/font-awesome-${version}.zip";
    name = "${name}";
    sha256 = "1lvxs4isrk80cczq6nrxksvqxs04k13i23i6c2l5vmfs2ndjsdm2";
  };

  # Apply only these phases
  phases = [ "unpackPhase" "installPhase" ];

  # Might not be required
  sourceRoot = ".";

  # Make unzip available during unpack
  buildInputs = [ unzip ];

  # Unzip the fetched zip file (-j means that everything is tossed into one folder)
  unpackPhase = ''
    unzip -j ${src}
  '';
  
  # Copy ttf and otf fonts out
  installPhase= ''
    mkdir -p $out/share/fonts/truetype
    cp *.{ttf,otf} $out/share/fonts/truetype
  '';
}
