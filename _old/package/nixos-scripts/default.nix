{
    stdenv, fetchFromGitHub
}:

stdenv.mkDerivation rec {
    name    = "nixos-scripts-${version}";
    version = "0.1";

    src = fetchFromGitHub {
        owner  = "matthiasbeyer";
        repo   = "nixos-scripts";
        rev    = "v${version}";
        sha256 = "191gifwka18gg6grly05h8gxph2yhhv09adfbc0x4f9slsy1inmq";
    };

    # Copy ttf and otf fonts out
    installPhase= ''
        mkdir -p $out/bin
        cp nix-script $out/bin
        cp *.sh $out/bin
    '';
}
