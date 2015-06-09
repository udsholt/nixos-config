{
    stdenv, fetchFromGitHub
}:

stdenv.mkDerivation rec {
    name    = "disque-${version}";
    version = "0.0.1";

    src = fetchFromGitHub {
        owner  = "antirez";
        repo   = "disque";
        rev    = "b5264359ddf0aa04a49b921c383c49ded7e7eea6";
        sha256 = "0n19yh55nirnjn6g3i9rrdys11q8cwk1ijgi1wvqipz74981yi9a";
    };

    makeFlags = "PREFIX=$(out)";
}
