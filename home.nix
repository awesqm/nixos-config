{ config, pkgs, ... }:

{
  home.username = "toxa";
  home.homeDirectory = "/home/toxa";
  
  home.packages = with pkgs; [
    zip
    xz
    unzip
    p7zip

    nnn

    btop
  ];

  home.stateVersion = "23.11";

  programs.home-manager.enable = true;
}
