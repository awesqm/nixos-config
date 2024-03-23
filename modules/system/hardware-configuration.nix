# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "thunderbolt" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/ec12f87c-0c25-453f-ab03-064416e718c6";
      fsType = "btrfs";
      options = [ "subvol=root" ];
    };

  boot.initrd.luks.devices."cryptroot".device = "/dev/disk/by-uuid/27c7ad9e-2c85-42c1-a772-e6714677872f";

  fileSystems."/home" =
    { device = "/dev/disk/by-uuid/ec12f87c-0c25-453f-ab03-064416e718c6";
      fsType = "btrfs";
      options = [ "subvol=home" ];
    };

  fileSystems."/.swap" =
    { device = "/dev/disk/by-uuid/ec12f87c-0c25-453f-ab03-064416e718c6";
      fsType = "btrfs";
      options = [ "subvol=swap" ];
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/0124-9A6F";
      fsType = "vfat";
    };

  fileSystems."/nix" =
    { device = "/dev/disk/by-uuid/ec12f87c-0c25-453f-ab03-064416e718c6";
      fsType = "btrfs";
      options = [ "subvol=nix" ];
    };

  swapDevices = [ ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp1s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}