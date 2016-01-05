{ stdenv, lib, fetchFromGitHub }:

let
    goDeps = [{
        root = "github.com/ddollar/forego";
        src = fetchFromGitHub {
            owner = "ddollar";
            repo = "forego";
            rev = "4eaf54121ea534d09e704a1227da35198e1ce283";
            sha256 = "0j71kwk9s3wnx7wl9fp0wjlmwdx5vjl09rzrz5dbpcr8669n2dy2";
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
