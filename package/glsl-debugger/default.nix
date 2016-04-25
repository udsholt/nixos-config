{
    stdenv, fetchFromGitHub, cmake, flex, bison, perl, qt4, freeglut, glew, mesa
}:

stdenv.mkDerivation rec {
    name = "glsl-debugger-${version}";
    version = "0.0.0";

    src = fetchFromGitHub {
        owner  = "GLSL-Debugger";
        repo   = "GLSL-Debugger";
        rev    = "97fa0d29868d6dfe762b845ac16d5ebfa7d46ce5";
        sha256 = "1ksskvcbcd00fqqkbf5ppgzsqqla7qr5a2ydw100v91c7pqvp15s";
    };

    buildInputs = [
        cmake

        flex
        bison
        perl

        qt4
        freeglut
        glew
        mesa
    ];

    enableParallelBuilding = true;

    installPhase = ''
        install -Dm755 bin/glsldb  $out/bin/glsldb
        install -Dm755 lib/libglslang.so  $out/lib/libglslang.so
    '';
}

# http://glsl-debugger.github.io/
