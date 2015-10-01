{
    stdenv, fetchurl, pkgconfig, makeWrapper,
    libnetfilter_queue, libnfnetlink, zlib
}:

# TODO: for some reason i can't make the command basename avaiable
#       in the shell scripts for pgl, whats up with that
stdenv.mkDerivation rec {
    name    = "pgl-${version}";
    version = "2.3.0";

    src = fetchurl {
        url = "https://downloads.sourceforge.net/project/peerguardian/PeerGuardian%20Linux/${version}/${name}.tar.gz";
        sha256 = "0lh7il3m173s43a4b55wv64yvvchjc75n5hkbwi7hisfcxm3i0s1";
    };

    buildInputs = [
        pkgconfig
        makeWrapper

        libnetfilter_queue
        libnfnetlink
        zlib
    ];

    configureFlags = [
        "--without-systemd"
        "--without-qt4"
        "--disable-dbus"
    ];
}
