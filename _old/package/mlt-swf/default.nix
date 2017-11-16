{
    stdenv,
    fetchurl,
    pkgconfig,
    makeWrapper,
    ffmpeg,
    frei0r,
    libdv,
    libjack2,
    libsamplerate,
    libvorbis,
    libxml2,
    movit,
    qt53,
    SDL,
    sox,
    swfdec
}:

stdenv.mkDerivation rec {
    name = "mlt-swf-${version}";
    version = "0.9.6";

    src = fetchurl {
        url = "https://github.com/mltframework/mlt/archive/v${version}.tar.gz";
        sha256 = "0s8ypg0q50zfcmq527y8cbdvzxhiqidm1923k28ar8jqmjp45ssh";
    };

    buildInputs = [
        pkgconfig
        makeWrapper

        ffmpeg
        frei0r
        libdv
        libjack2
        libsamplerate
        libvorbis
        libxml2
        movit
        qt53
        SDL
        sox
        swfdec
    ];

    configureFlags = [
        "--avformat-swscale"
        "--enable-gpl"
        "--enable-gpl"
        "--enable-gpl3"
        "--enable-opengl"
    ];

    enableParallelBuilding = true;

    postInstall = ''
        wrapProgram $out/bin/melt --prefix FREI0R_PATH : ${frei0r}/lib/frei0r-1
    '';

    meta = with stdenv.lib; {
        description = "Open source multimedia framework, designed for television broadcasting";
        homepage = http://www.mltframework.org/;
        license = licenses.gpl3;
        maintainers = [ maintainers.goibhniu ];
        platforms = platforms.linux;
    };
}