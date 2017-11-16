{ stdenv, fetchurl, unzip }:

stdenv.mkDerivation rec {

  name = "font-awesome-${version}";
  version = "4.7.0";

  # Fetch the zip file
  # Im not entirely sure what name does here
  src = fetchurl {
    url = "http://fontawesome.io/assets/${name}.zip";
    name = "${name}";
    sha256 = "00jqiszvb8i95bpj7iwi9pgqabs1xfpm618nj1md7rklx2wyvdm7";
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