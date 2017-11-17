# This file was generated by https://github.com/kamilchm/go2nix v1.2.1
{ stdenv, buildGoPackage, fetchgit, fetchhg, fetchbzr, fetchsvn }:

buildGoPackage rec {
  name = "forego-unstable-${version}";
  version = "2015-03-27";
  rev = "09d2395bae50fd15e382a7983aea75014f99b7e0";

  goPackagePath = "github.com/ddollar/forego";

  src = fetchgit {
    inherit rev;
    url = "https://github.com/udsholt/forego.git";
    sha256 = "1c8qi0fwdf9q14cdwhlhy71js9c6ndx0ns6cffqhj0pl9mh1vdv3";
  };

  # TODO: add metadata https://nixos.org/nixpkgs/manual/#sec-standard-meta-attributes
  meta = {
  };
}

