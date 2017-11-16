{
    stdenv, fetchurl, pkgconfig,
    gnome3
}:

stdenv.mkDerivation rec {
    name    = "gtksourceviewmm-${version}";
    version = "3.18";

    buildInputs =  [
        pkgconfig

        gnome3.gtkmm
        gnome3.gtkmm
        gnome3.gtksourceview
    ];

    src = fetchurl {
        url = "https://download.gnome.org/sources/gtksourceviewmm/${version}/${name}.0.tar.xz";
        sha256 = "0fgvmhm4h4qmxig87qvangs6ijw53mi40siz7pixlxbrsgiil22i";
    };

    propagatedBuildInputs = [
        gnome3.gtksourceview
    ];
}

/*

C++ wrapper for gtksourceview, version 3.2.0.

Current dependencies:
- to build a library from tarball:
  * gtksourceview >= 3.2.0
  * glibmm >= 2.28.0
  * gtkmm >= 3.2.0
- to build a documentation:
  * same as above and tools required by mm-common, that are:
    - perl
    - doxygen
    - dot
    - xsltproc
- to build in maintainer mode:
  * same as above and tools used by maintainer:
    - git (to generate a ChangeLog)
    - mm-common >= 0.9.5
    - recent autotools because no deprecated macros are used.

*/