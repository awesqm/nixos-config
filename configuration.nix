# THIS FILE IS NO LONGER IN USE!

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];
  

  nix.settings.experimental-features = [ "nix-command" "flakes" ];


  nixpkgs.config.allowUnfree = true;
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 10;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 1w";
  };
  nix.settings.auto-optimise-store = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.initrd.kernelModules = [ "amdgpu" ];


  networking.hostName = "zn"; # Define your hostname.
  
  fileSystems = {
    "/".options = [ "compress=zstd" ];
    "/home".options = [ "compress=zstd" ];
    "/nix".options = [ "compress=zstd" "noatime" ];
    "/.swap".options = [ "compress=none" "noatime" ];
  };
  swapDevices = [ { device = "/.swap/swapfile"; size = 30*1024; } ];
  time.timeZone = "Europe/Moscow";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "amdgpu" ];
  hardware.opengl.driSupport = true;
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  
  # nixpkgs.config.allowAliases = false;
  

  
  services.auto-cpufreq.enable = true;
  nixpkgs.config.obsidian.commandLineArgs = "--enable-features=UseOzonePlatform --ozone-platform=wayland";
  # Enable CUPS to print documents.
  # services.printing.enable = true;
  
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  hardware.pulseaudio.enable = false;
  # Enable sound.
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.toxa = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    hashedPasswordFile = "/home/toxa/.funnytext";
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    git
    sshfs
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    neovim
    waybar
    chromium
    firefox
    mkpasswd
    obsidian
    bitwarden-desktop
    alacritty
    tofi
    vesktop
    telegram-desktop
    inter
    tela-icon-theme
    gnome.adwaita-icon-theme
    vscodium-fhs
    llvmPackages.libcxxClang
    clang-tools
    libcxx
    libcxxStdenv
    wl-clipboard-rs
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  environment.sessionVariables.WLR_DRM_NO_ATOMIC = "1";

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  #networking.networkmanager.enable = true;
  #networking.networkmanager.wifi.backend = "iwd";
  #networking.wireless.iwd.settings.Settings.AutoConnect = true;


  networking.wireless.iwd.enable = true;
  networking.wireless.iwd.settings = {
    IPv6 = {
      Enabled = true;
    };
    Settings = {
      AutoConnect = true;
    };
  };
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  system.stateVersion = "23.11"; # Did you read the comment?  i did.

}

