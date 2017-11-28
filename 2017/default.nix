let
  inherit (import <nixpkgs> {}) fetchFromGitHub lib;
  versions = lib.mapAttrs
    (_: fetchFromGitHub)
    (builtins.fromJSON (builtins.readFile ./versions.json));
  # ./updater versions.json ihaskell
  IHaskell = versions.ihaskell;
  # ./updater versions.json nixpkgs nixos-17.09
  pinned   = versions.nixpkgs;
  nixpkgs  = import pinned {};
in import "${IHaskell}/release.nix" {
  inherit nixpkgs;
  packages = self: with self; [
    attoparsec
    bytestring
    containers
    directory
    filepath
    lens
    (nixpkgs.haskell.lib.dontHaddock (nixpkgs.haskellPackages.callCabal2nix "lib" ./lib {}))
    split
    utf8-string
    vector
  ];
}
