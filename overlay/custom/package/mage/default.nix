{ stdenv, buildGoPackage, fetchgit, fetchhg, fetchbzr, fetchsvn }:

buildGoPackage rec {
  name = "mage-${version}";
  version = "v1.8.0";
  rev = "v1.8.0";

  goPackagePath = "github.com/magefile/mage";
  excludedPackages = [ "github.com/magefile/mage/mage/testdata" ];

  src = fetchgit {
    inherit rev;
    url = "https://github.com/magefile/mage.git";
    sha256 = "0vkzm2k2v3np30kdgz9kpwkhnshbjcn8j1y321djz2h3w23k5h7r";
  };
}
