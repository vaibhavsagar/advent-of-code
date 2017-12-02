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
    async
    attoparsec
    base16-bytestring
    bytestring
    containers
    cryptonite
    here
    memory
    split
    utf8-string
    vector
  ];
}
