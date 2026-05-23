{ pkgs, ... }:
let
  myPython = pkgs.python3.withPackages (ps: with ps; [
    # Emacs python packages (epc, sexpdata needed for emacs-epc bridge)
    epc
    sexpdata
    ipython
  ]);

  myFonts = import ./fonts.nix { inherit pkgs; };
in

with pkgs; [
  # A
  act # Run Github actions locally
  age # File encryption tool
  aspell # Spell checker
  aspellDicts.en
  aspellDicts.el
  aspellDicts.grc
  aspellDicts.la

  # B
  bash-completion
  bat # Cat clone with syntax highlighting

  # C
  coreutils

  # D
  direnv
  difftastic
  djvulibre
  docker

  # E
  exiftool

  # F
  fd
  fzf
  ffmpeg

  # G
  gh # GitHub CLI
  ghostscript # PDF rendering
  gnupg

  # H
  htop
  hunspell
  hunspellDicts.en_US
  hunspellDicts.ru_RU
  hunspellDicts.el_GR

  # I
  iftop

  # L
  lnav
  libpng

  # M
  myPython
  math-preview

  # N
  ncurses
  ncdu
  nethack

  # O
  openssh

  # P
  pass
  pandoc
  poppler

  # R
  ripgrep

  # S
  sqlite
  symlinks
  starship

  # T
  tree

  # U
  unrar
  unzip
  uv # Python package manager (system-level tool)

  # W
  wget

  # Y
  yt-dlp

  # Z
  zip
  zoxide
  zlib

] ++ myFonts
