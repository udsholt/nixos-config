{
    stdenv,
    fetchurl,
    cmake,
    ninja
}:

stdenv.mkDerivation rec {
    name = "flatcc-${version}";
    version = "0.4.1";

    src = fetchurl {
        url = "https://github.com/dvidelabs/flatcc/archive/v${version}.tar.gz";
        sha256 = "1pw7wjp3ah32jy821y18yk0nb06ck104zp7qhl44rcjman76d7yy";
    };

    buildInputs = [
        cmake
        ninja
    ];

    phases = [ "unpackPhase" "buildPhase" "installPhase" ];

    buildPhase = ''
        scripts/build.sh
    '';

    installPhase = ''
        mkdir -p $out/bin
        mkdir -p $out/lib
        mkdir -p $out/include

        cp bin/* $out/bin
        cp lib/* $out/lib
        cp bin/* $out/bin
    '';
}