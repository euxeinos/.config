{ pkgs }:

with pkgs;
let shared-packages = import ../shared/packages.nix { inherit pkgs; }; in
shared-packages ++ [
  home-manager

  # F 
  fontconfig
  font-manager
  fuzzel

  libnotify


  # C
  chatgpt-cli

  # G

  # L
  libgccjit
  binutils
  cmake
  gnumake

  # M

  # N

  # P

  # S
  swaybg
  syncthing

  # T
  tailscale
]
