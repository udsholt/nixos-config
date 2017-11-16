{ stdenv, lib, fetchFromGitHub }:

let
    goDeps = [{
        root = "github.com/ddollar/forego";
        src = fetchFromGitHub {
            owner = "udsholt";
            repo = "forego";
            rev = "09d2395bae50fd15e382a7983aea75014f99b7e0";
            sha256 = "1c8qi0fwdf9q14cdwhlhy71js9c6ndx0ns6cffqhj0pl9mh1vdv3";
        };
    }];
in

stdenv.mkDerivation rec {
    name = "go-deps";

    buildCommand =
        lib.concatStrings (map (dep: ''
            mkdir -p $out/src/`dirname ${dep.root}`
            ln -s ${dep.src} $out/src/${dep.root}
        '') goDeps);
}
