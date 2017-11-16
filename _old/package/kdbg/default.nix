# from: https://github.com/NixOS/nixpkgs/pull/12915 with added icons to make the ui useful
{ stdenv, fetchurl, makeWrapper, cmake, kdelibs, automoc4, gdb,  oxygen_icons  }:

stdenv.mkDerivation rec {
    name = "kdbg-${version}";
    version = "2.5.5";
    src = fetchurl {
        url = "mirror://sourceforge/kdbg/${version}/${name}.tar.gz";
        sha256 = "0yc8hy8ip6din2jjq4r8cd8jnda0kry2abcy8i12yxcd4n4lqglq";
    };

    buildInputs = [ cmake kdelibs automoc4 gdb makeWrapper ];

    propagatedUserEnvPkgs = [ oxygen_icons ];

    patchPhase = ''
        sed '6 a \
        include(CheckIncludeFiles)' -i kdbg/CMakeLists.txt
    '';

    fixupPhase = ''
        wrapProgram $out/bin/kdbg                               \
            --prefix XDG_DATA_DIRS : "${oxygen_icons}/share"    \
            --prefix PATH : "${gdb}/bin"
    '';

    enableParallelBuilding = true;

    meta = with stdenv.lib; {
        homepage = http://www.kdbg.org/;
        description = ''
            A graphical user interface to gdb, the GNU debugger. It provides an
            intuitive interface for setting breakpoints, inspecting variables, and
            stepping through code.
        '';
    };
}
