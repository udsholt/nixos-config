# This file was generated by https://github.com/kamilchm/go2nix v1.2.1
{ stdenv, buildGoPackage, fetchgit, fetchhg, fetchbzr, fetchsvn }:

buildGoPackage rec {
  name = "go-symbols-unstable-${version}";
  version = "2017-02-06";
  rev = "5a7f75904fb552189036c640d04cd6afef664836";

  goPackagePath = "github.com/acroca/go-symbols";

  src = fetchgit {
    inherit rev;
    url = "https://github.com/acroca/go-symbols.git";
    sha256 = "0qh2jjhwwk48gi8yii0z031bah11anxfz81nwflsiww7n426a8bb";
  };

  goDeps = ./deps.nix;

  # TODO: add metadata https://nixos.org/nixpkgs/manual/#sec-standard-meta-attributes
  meta = {
  };
}
