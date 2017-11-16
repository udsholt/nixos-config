{ stdenv, fetchgit }:

stdenv.mkDerivation rec {
    name = "premake-${version}";
    version = "5.0.0-alpha7";

    # The distributed source packages are misconfigured for linux
    # and building from source requires submodules.
    src = fetchgit {
        url = "https://github.com/premake/premake-core.git";
        rev = "745d65e8a939061bc12f2c42d266d8251a49dbf6";
        fetchSubmodules = true;
        sha256 = "1zdhqqyvnsj1s7kkrzzhaml3byirg70b6iqf0mwvajj3sankadiy";
    };

    buildPhase = ''
        make -f Bootstrap.mak linux
    '';

    installPhase = ''
        install -Dm755 bin/release/premake5 $out/bin/premake5
    '';
}
