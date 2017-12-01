let
  inherit (import <nixpkgs> {}) fetchFromGitHub lib;
  # ./updater versions.json ihaskell
  # ./updater versions.json nixpkgs nixos-17.09
  versions = lib.mapAttrs
    (_: fetchFromGitHub)
    (builtins.fromJSON (builtins.readFile ./versions.json));
  nixpkgs  = import versions.nixpkgs {};
in import "${versions.ihaskell}/release.nix" {
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
    unordered-containers
    utf8-string
    vector
  ];
}
