{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.xserver.windowManager.airblader;
in

{
  options = {
    services.xserver.windowManager.airblader = {
      enable = mkOption {
        default = false;
        example = true;
        description = "Enable the airblader window manager.";
      };

      configFile = mkOption {
        default = null;
        type = types.nullOr types.path;
        description = ''
          Path to the airblader configuration file.
          If left at the default value, $HOME/.i3/config will be used.
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    services.xserver.windowManager = {
      session = [{
        name = "airblader";
        start = ''
          ${pkgs.airblader}/bin/i3 ${optionalString (cfg.configFile != null)
            "-c \"${cfg.configFile}\""
          } &
          waitPID=$!
        '';
      }];
    };
    environment.systemPackages = [ pkgs.airblader ];
  };
}
