{ config, pkgs, ... }:

{
    containers.disque = {
        config = { config, pkgs, ... }: {

            nixpkgs.config.packageOverrides = import ../override;
            require = [ ../module/disque ];

            services.disque = {
                enable = true;
            };
        };
    };
}
