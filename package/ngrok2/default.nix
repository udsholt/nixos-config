{
    stdenv, fetchurl, unzip
}:

# TODO: for some reason i can't make the command basename avaiable
#       in the shell scripts for pgl, whats up with that
stdenv.mkDerivation rec {
    name    = "ngrok-${version}";
    version = "2.0.19";

    src = fetchurl {
        url = "https://dl.ngrok.com/ngrok_${version}_linux_amd64.zip";
        sha256 = "0w4gzfabm4mj87vjncp76i05rp45m3i1qd773cr15i661z3a1bdn";
    };

    buildInputs = [ unzip ];

    sourceRoot = ".";

    unpackPhase = ''
        unzip -j ${src}
    '';

    installPhase = ''
        mkdir -p $out/bin
        cp ngrok $out/bin

        patchelf --set-interpreter ${stdenv.glibc}/lib/ld-linux-x86-64.so.2 $out/bin/ngrok
        patchelf --set-rpath ${stdenv.glibc}/lib $out/bin/ngrok
    '';
}
