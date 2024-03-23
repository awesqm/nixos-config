{config, pkgs, ...}:

{
  environment.systemPackages = with pkgs; [
    git
    sshfs
    neovim
    wget
    neovim
    waybar
    mkpasswd
    llvmPackages.libcxxClang
    clang-tools
    libcxx
    libcxxStdenv
    
  ];
}