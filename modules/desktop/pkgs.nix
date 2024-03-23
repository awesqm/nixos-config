{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    hyprpaper
    hypridle
    hyprlock
    alacritty
    dunst
    tofi

    grim
    slurp
    wl-clipboard-rs
    libnotify
    greetd.tuigreet
    brightnessctl
    alsa-utils
    pulsemixer
    cava
    libsecret

    keepassxc
    #nextcloud-client
    obsidian
    vscodium-fhs
    inter

    vesktop
    telegram-desktop
    
    chromium
    poweralertd
  ];

  #services.ratbagd.enable = true;
  #services.upower.enable = true;

  programs = {
    hyprland.enable = true;
  };

  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "VictorMono" ]; })
  ];
}
