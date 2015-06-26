{ stdenv, fetchurl, unzip }:

stdenv.mkDerivation rec {

  name = "font-awesome-4.3.0";
  
  # Fetch the zip file
  # Im not entirely sure what name does here
  src = fetchurl {
    url = "http://fortawesome.github.io/Font-Awesome/assets/font-awesome-4.3.0.zip";
    name = "${name}";
    sha256 = "0wg9q6mq026jjw1bsyj9b5dgba7bb4h7i9xiwgsfckd412xpsbzd";
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
