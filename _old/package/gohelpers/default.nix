{ stdenv, lib, fetchurl }:

stdenv.mkDerivation rec {
  name = "gohelpers";

  src = ./src;

  installPhase = ''
    mkdir -p $out/bin
    cp ${src}/* $out/bin/
    chmod +x $out/bin/*
  '';
}
