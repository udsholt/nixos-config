{
    stdenv,
    fetchurl,
    makeWrapper,
    jre
}:

stdenv.mkDerivation rec {
    name = "moonlight-${version}";
    version = "0.6.1";
    target = "${name}.jar";

    src = fetchurl {
        url = "https://github.com/moonlight-stream/moonlight-pc/releases/download/v0.6.1/moonlight-lin64.jar";
        name = "${name}";
        sha256 = "0adjjxrahxfzrsmz89b00drs5a3wy5y3wbx0mdx8x1gvrjhziv83";
    };

    buildInputs = [ makeWrapper ];

    phases = [ "installPhase" ];

    installPhase= ''
        mkdir -p $out/bin
        mkdir -p $out/lib

        cp $src $out/lib/${target}

        makeWrapper ${jre}/bin/java $out/bin/moonlight \
            --add-flags "-jar $out/lib/${target}"
    '';
}