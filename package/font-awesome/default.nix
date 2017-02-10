{ stdenv, fetchurl, unzip }:

stdenv.mkDerivation rec {

  name = "font-awesome-${version}";
  version = "4.7.0";

  # Fetch the zip file
  # Im not entirely sure what name does here
  src = fetchurl {
    url = "http://fontawesome.io/assets/${name}.zip";
    name = "${name}";
    sha256 = "06wygg71zi8wg88dl83l3p5fvkld0nhkh096djbxblpnpzibr6yd";
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