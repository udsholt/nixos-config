{ stdenv, fetchurl, unzip }:

stdenv.mkDerivation rec {

  name = "font-awesome";
  version = "4.5.0";
  
  # Fetch the zip file
  # Im not entirely sure what name does here
  src = fetchurl {
    url = "https://fortawesome.github.io/Font-Awesome/assets/font-awesome-${version}.zip";
    name = "${name}";
    sha256 = "0mhd5z88bmcdmyylvp6sgh5a9vibwv9qxcs1a63aydc0jwznjawz";
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
