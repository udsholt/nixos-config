{ stdenv, fetchurl, unzip }:

stdenv.mkDerivation rec {

  name = "font-awesome";
  version = "4.4.0";
  
  # Fetch the zip file
  # Im not entirely sure what name does here
  src = fetchurl {
    url = "https://fortawesome.github.io/Font-Awesome/assets/font-awesome-${version}.zip";
    name = "${name}";
    sha256 = "1k7ff71pcp2qrnqj4yzrjg96m7yma9r58wdk68sqb93q2kq9fp3i";
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
