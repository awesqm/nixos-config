{ config, lib, pkgs, ... }:
{
  imports =
    [
      ./hardware-configuration.nix
      ./boot.nix
      ./pkgs.nix
    ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nixpkgs.config.allowUnfree = true;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 1w";
  };
  nix.settings.auto-optimise-store = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.initrd.kernelModules = [ "amdgpu" ];


  networking.hostName = "zn";
  
  time.timeZone = "Europe/Moscow";

  i18n.defaultLocale = "en_US.UTF-8";

  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "amdgpu" ];
  hardware.opengl.driSupport = true;
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  
  services.auto-cpufreq.enable = true;
  nixpkgs.config.obsidian.commandLineArgs = "--enable-features=UseOzonePlatform --ozone-platform=wayland";
  
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  hardware.pulseaudio.enable = false;

  users.users.toxa = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    hashedPasswordFile = "/home/toxa/.funnytext";
  };



  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  environment.sessionVariables.WLR_DRM_NO_ATOMIC = "1";

  services.openssh.enable = true;

  networking.wireless.iwd.enable = true;
  networking.wireless.iwd.settings = {
    IPv6 = {
      Enabled = true;
    };
    Settings = {
      AutoConnect = true;
    };
  };

  system.stateVersion = "23.11"; # Did you read the comment?  i did.

}

