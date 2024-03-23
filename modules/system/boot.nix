{config, pkgs, ...}:
{
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 10;
  fileSystems = {
    "/".options = [ "compress=zstd" ];
    "/home".options = [ "compress=zstd" ];
    "/nix".options = [ "compress=zstd" "noatime" ];
    "/.swap".options = [ "compress=none" "noatime" ];
  };
  swapDevices = [ { device = "/.swap/swapfile"; size = 30*1024; } ];
}