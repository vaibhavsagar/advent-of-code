let
  inherit (import <nixpkgs> {}) fetchFromGitHub lib;
  # ./updater versions.json ihaskell
  # ./updater versions.json nixpkgs nixos-17.09
  versions = lib.mapAttrs
    (_: fetchFromGitHub)
    (builtins.fromJSON (builtins.readFile ../versions.json));
  nixpkgs  = import versions.nixpkgs {};
  drv = (nixpkgs.haskell.lib.dontHaddock (nixpkgs.haskellPackages.callCabal2nix "lib" ./. {}));
in
  if lib.inNixShell then drv.env else drv
