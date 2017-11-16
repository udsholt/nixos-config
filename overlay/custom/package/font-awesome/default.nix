{ stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  name = "font-awesome-${version}";
  version = "4.7.0";

  src = fetchFromGitHub {
    owner  = "FortAwesome";
    repo   = "Font-Awesome";
    rev    = "v${version}";
    sha256 = "0w30y26jp8nvxa3iiw7ayl6rkza1rz62msl9xw3srvxya1c77grc";
  };

  # Apply only these phases
  phases = [ "installPhase" ];

  # Copy ttf and otf fonts out
  installPhase= ''
    mkdir -p $out/share/fonts/truetype
    cp $src/fonts/*.{ttf,otf} $out/share/fonts/truetype
  '';
}
