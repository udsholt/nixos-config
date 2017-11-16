{ stdenv, lib, fetchFromGitHub }:

let
    goDeps = [{
        root = "github.com/svent/sift";
        src = fetchFromGitHub {
            owner  = "svent";
            repo   = "sift";
            rev    = "74cb876cf8d6a4fdefcad0c4c0e95f40db3df1de";
            sha256 = "1kbclfwnl136w80zxmr8k4b2fmazsigqvam8xw108z5pc7mcyfn6";
        };
    }{
        root = "github.com/svent/go-flags";
        src = fetchFromGitHub {
            owner  = "svent";
            repo   = "go-flags";
            rev    = "4bcbad344f0318adaf7aabc16929701459009aa3";
            sha256 = "1gb416fgxl9gq4q6wsv3i2grq1mzbi7lvfvmfdqbxqbv9vizzh34";
        };
    }{
        root = "github.com/svent/go-nbreader";
        src = fetchFromGitHub {
            owner  = "svent";
            repo   = "go-nbreader";
            rev    = "7cef48da76dca6a496faa7fe63e39ed665cbd219";
            sha256 = "0hw11jj5r3f6qwydg41nc3c6aadlbkhc1qpxra2609lis0qa9h4r";
        };
    }{
        root = "golang.org/x/crypto";
        src = fetchFromGitHub {
            owner  = "golang";
            repo   = "crypto";
            rev    = "575fdbe86e5dd89229707ebec0575ce7d088a4a6";
            sha256 = "1kgv1mkw9y404pk3lcwbs0vgl133mwyp294i18jg9hp10s5d56xa";
        };
    }];

    makeDep = dep : ''
      mkdir -p $out/src/`dirname ${dep.root}`
      ln -s ${dep.src} $out/src/${dep.root}
    '';

in

stdenv.mkDerivation rec {
    name = "go-deps";

    buildCommand = lib.concatStrings (map (makeDep) goDeps);
}