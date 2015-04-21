{ config, pkgs, ... }:

{
  require = [
    ./system/kaaresyv.nix
    
    ./common/user.nix
    ./common/base.nix
    ./common/i3wm.nix
  ];
}
