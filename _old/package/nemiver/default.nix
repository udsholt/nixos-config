{
    stdenv, fetchurl,

    pkgconfig,
    intltool,
    itstool,
    libxml2,            # provides `xmllint'
    wrapGAppsHook,

    glib,               # glib-2.46.2
    glibmm,             # glibmm-2.44.0
    libgtop,            # libgtop-2.32.0
    sqlite,             # sqlite-3.9.2
    gdb,                # gdb-7.11
    boost,              # boost-1.59.0

    gtksourceviewmm,    # gtksourceviewmm-3.18

    gnome3,             # gtkmm-3.16.0
                        # gsettings-desktop-schemas-3.18.1
                        # vte-0.42.1
                        # gconf-3.2.6
}:

stdenv.mkDerivation rec {
    name    = "nemiver-${version}";
    version = "0.9.6";

    buildInputs =  [
        pkgconfig
        intltool
        itstool
        libxml2
        wrapGAppsHook

        glib
        glibmm
        libgtop
        sqlite
        gdb
        boost

        gtksourceviewmm

        gnome3.gtkmm
        gnome3.gsettings_desktop_schemas
        gnome3.vte
        gnome3.gconf
    ];

    patches = [ ./some.patch ];


    src = fetchurl {
        url = "https://download.gnome.org/sources/nemiver/0.9/${name}.tar.xz";
        sha256 = "1wjfd5mr8pjmlf4p6s6hacy5q1vx2jk542fb87s64cpqqkv8raw5";
    };

    /*
    preConfigure = ''
        export PKG_CONFIG_PATH="${gnome3.gtksourceview}/lib/pkgconfig:$PKG_CONFIG_PATH"
    '';
    */

    # makeFlags = "PREFIX=$(out)";
}

# http://jonathonreinhart.blogspot.dk/2014/12/installing-nemiver-on-centos-7.html

/*

https://gitweb.gentoo.org/repo/gentoo.git/tree/dev-util/nemiver/nemiver-0.9.6.ebuild?id=fed6d33f9225880e48e1c9cdc91d4365728bbb45

RDEPEND="
x    >=dev-libs/glib-2.16:2
x    >=dev-cpp/glibmm-2.30:2
x    >=dev-cpp/gtkmm-3:3.0
x    >=dev-cpp/gtksourceviewmm-3:3.0
x    >=gnome-base/gsettings-desktop-schemas-0.0.1
x    >=gnome-base/libgtop-2.19
x    x11-libs/vte:2.91
x    >=dev-db/sqlite-3:3
x    sys-devel/gdb
    dev-libs/boost
    memoryview? ( >=app-editors/ghex-2.90:2 )
"
# FIXME: dynamiclayout needs unreleased stable gdlmm:3
# dynamiclayout? ( >=dev-cpp/gdlmm-3.0:3 )
DEPEND="${RDEPEND}
    app-text/docbook-xml-dtd:4.1.2
    >=dev-util/intltool-0.40
    dev-util/itstool
    >=sys-devel/gettext-0.17
    virtual/pkgconfig
"

*/