{ config, pkgs, ... }:

{
  home.username = "toxa";
  home.homeDirectory = "/home/toxa";

  home.stateVersion = "23.11";

  programs.home-manager.enable = true;
}
