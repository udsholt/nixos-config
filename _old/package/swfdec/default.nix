{
    stdenv,
    fetchurl,
    pkgconfig,
    alsaLib,
    glib,
    gtk,
    libsoup,
    zlib,
    cairo,
    liboil,
    pango
}:

stdenv.mkDerivation rec {
    name = "swfdec-${version}";
    version = "0.9.2";

    src = fetchurl {
        url = "http://swfdec.freedesktop.org/download/swfdec/0.9/swfdec-${version}.tar.gz";
        sha256 = "1vzi63j5l0wwsajxmx7ca5pdnsvgmbckjdrg955wmrqr9h2a6mkx";
    };

    configureFlags = [
        "--enable-gstreamer=false"
    ];

    buildInputs = [
        pkgconfig 

        alsaLib
        glib
        gtk
        libsoup
        zlib
    ];

    propagatedBuildInputs = [
        cairo
        liboil
        pango
    ];
}
