{ config, lib, pkgs, ... }:

with lib;

let
    cfg = config.services.pcophp;

    lighttpdExtraConfig = ''
        mimetype.assign += (
          ".js" => "text/javascript",
          ".svg" => "image/svg+xml"
        )

        fastcgi.server += ( 
            ".php" => (
                "localhost" => ( "socket" => "/run/phpfpm/localhost.sock" )
            )
        )

        $SERVER["socket"] == ":443" {
            ssl.engine = "enable"
            ssl.pemfile = "/etc/lighttpd/localhost.cert.pem"
        }

        $HTTP["host"] =~ "\.lo" {
            index-file.names = ("index.php")
            evhost.path-pattern = "/srv/www/%2/web/" 
            accesslog.filename  = "/srv/www/access.log"
            server.reject-expect-100-with-417 = "disable"
            setenv.add-environment = (
                "PEYTZ_ENV" => "dev",
                "SILEX_ENV" => "dev",
            )
            url.rewrite-if-not-file = (
                "^/$" => "$0",
                "^/(?!.+\.php)[^\?]+(\?.*)?" => "index.php/$1$2",
            )
        }

        ${concatStringsSep "\n" (map (evhost : ''${evhost}'') cfg.extraLighttpdEvhosts) }
    '';
in

{
    options = {
        services.pcophp = {
            enable = mkOption {
                default = false;
                example = true;
                description = "Enable pcophp";
            };

            extraLighttpdEvhosts = mkOption {
                default = [ ];
                description = "Lighttpd vhost configuration";
                example = [
                    ''
                    $HTTP["host"] =~ "\.lo" {
                        index-file.names = ("index.php")
                        evhost.path-pattern = "/srv/www/%2/web/" 
                        accesslog.filename  = "/srv/www/access.log"
                        server.reject-expect-100-with-417 = "disable"
                        setenv.add-environment = (
                            "PEYTZ_ENV" => "dev",
                            "SILEX_ENV" => "dev",
                        )
                        url.rewrite-if-not-file = (
                            "^/$" => "$0",
                            "^/(?!.+\.php)[^\?]+(\?.*)?" => "index.php/$1$2",
                        )
                    }
                    ''
                ];
            };
        };
    };

    config = mkIf cfg.enable {

        # PHP packages
        environment.systemPackages = with pkgs; [
            pkgs.php
            pkgs.phpPackages.composer
            pkgs.phpPackages.memcached
            pkgs.phpPackages.redis
        ];

        # Enable php extensions
        environment.etc."php.extra.ini" = {
            text = ''
            date.timezone = "Europe/Copenhagen"
            extension=${pkgs.phpPackages.memcached}/lib/php/extensions/memcached.so
            extension=${pkgs.phpPackages.redis}/lib/php/extensions/redis.so
            '';
        };

        # PHP FPM
        # https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/services/web-servers/phpfpm.nix
        services.phpfpm = {
            phpPackage = pkgs.php;
            poolConfigs = {
                localhost = ''
                    listen = /run/phpfpm/localhost.sock
                    listen.owner = lighttpd
                    listen.mode=0660

                    user = nobody
                    pm = dynamic
                    pm.max_children = 75
                    pm.start_servers = 10
                    pm.min_spare_servers = 5
                    pm.max_spare_servers = 20
                    pm.max_requests = 500
                '';
            };
        };

        # Lighttpd claims that mod_rewrite is loaded twice, however url.rewrite-if-not-file will not
        # work without it double include... strange
        services.lighttpd = {
            enable = true;
            document-root = "/srv/www/default";
            enableModules = [ "mod_evhost" "mod_accesslog" "mod_setenv" "mod_fastcgi" "mod_rewrite" ];
            extraConfig = lighttpdExtraConfig;
        };

        # Self signed certificate for localhost
        environment.etc."lighttpd/localhost.cert.pem" = {
            source = ./resource/localhost.cert.pem;
            mode = "0400";
        };
    };
    
}
