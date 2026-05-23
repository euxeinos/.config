{ config, pkgs, emacs-overlay, telega-overlay, ... }:

let
  myEmacs = import ./config/emacs/emacs.nix { inherit pkgs; };
in
{
  nixpkgs = {
    config = {
      allowUnfree = true;
    };

    overlays =
      let
        path = ../../overlays;
      in with builtins;
        map (n: import (path + ("/" + n)))
          (filter (n:
            (match ".*\\.nix" n != null ||
             pathExists (path + ("/" + n + "/default.nix"))))
              (attrNames (readDir path)))

      ++ [ emacs-overlay.overlays.default ]
      ++ [ (import telega-overlay) ];
  };
}
