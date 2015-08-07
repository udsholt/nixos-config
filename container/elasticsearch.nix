{ config, pkgs, ... }:

{
    containers.elasticsearch = {
        config = { config, pkgs, ... }: {
            nixpkgs.config = {
                allowUnfree = true;
                packageOverrides = pkgs: rec {
                    jre       = pkgs.oraclejre8;
                    jdk       = pkgs.oraclejdk8;
                    jdkdistro = pkgs.oraclejdk8distro;

                    # sha256 was wrong for plugin, so update it to the newest
                    elasticsearchKopf = pkgs.stdenv.lib.overrideDerivation pkgs.elasticsearchPlugins.elasticsearch_kopf (oldAttrs: rec {
                        name = "elasticsearch-kopf-${version}";
                        version = "1.5.6";
                        src = pkgs.fetchurl {
                            url = "https://github.com/lmenezes/elasticsearch-kopf/archive/v${version}.zip";
                            sha256 = "10w2n9zg7yr0cxziv0hr8m29ppjn9c1379a7a6j2lfvbbhs8jlyw";
                        };
                    });
                };
            };

            services.elasticsearch = {
                enable = true;
                port = 9200;
                tcp_port = 9300;
                cluster_name = "elasticsearch";
                dataDir = "/var/lib/elasticsearch";
                plugins = [
                    pkgs.elasticsearchKopf
                ];
            };
        };
    };
}
