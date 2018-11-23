{
    stdenv,
    fetchurl,
    fetchzip,
    makeWrapper,
    jre
}:

stdenv.mkDerivation rec {
    name = "sql-workbench-${version}";
    version = "124";

    src = fetchzip {
        url = "https://www.sql-workbench.eu/Workbench-Build${version}.zip";
        sha256 = "1rxhhcxqj44r6jahajkyi6klbnn5d7nhxd2car8hkkvgpjcdzzbq";
        stripRoot = false;
    };

    redshift-src = fetchurl {
        url = "https://s3.amazonaws.com/redshift-downloads/drivers/RedshiftJDBC42-1.2.1.1001.jar";
        sha256 = "06iafd3qjhawi5j9v8p4aljd8swws4y0dxrs5y8mvk1jijih8k0k";
    };

    nativeBuildInputs = [ makeWrapper ];

    installPhase = ''
        mkdir -p $out/bin
        mkdir -p $out/driver

        cp ${redshift-src} $out/driver/RedshiftJDBC42-1.2.1.1001.jar

        mv sqlworkbench.jar $out/bin/
        mv sqlworkbench.sh  $out/bin/sql-workbench
        chmod +x $out/bin/sql-workbench

        wrapProgram $out/bin/sql-workbench --set JAVA_HOME ${jre} --add-flags "-libdir=\"$out/driver\""
    '';
}