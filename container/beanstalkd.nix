{ config, pkgs, ... }:

{
    containers.beanstalkd = {
        config = { config, pkgs, ... }: {

            nixpkgs.config.packageOverrides = import ../override;
            require = [ ../module/beanstalkd ];

            services.beanstalkd = {
                enable = true;
                port = 11300;
            };
        };
    };
}
