let
  fetcher = { owner, repo, rev, sha256, ... }: builtins.fetchTarball {
    inherit sha256;
    url = "https://github.com/${owner}/${repo}/archive/${rev}.tar.gz";
  };
  inherit (import <nixpkgs> {}) lib;
  # ./updater versions.json ihaskell
  # ./updater versions.json nixpkgs nixos-17.09
  versions = lib.mapAttrs
    (_: fetcher)
    (builtins.fromJSON (builtins.readFile ./versions.json));
  nixpkgs = import versions.nixpkgs {};
in import "${versions.ihaskell}/release.nix" {
  inherit nixpkgs;
  compiler = "ghc844";
  packages = self: with self; [
    attoparsec
    bytestring
    containers
    directory
    fgl
    filepath
    ihaskell-charts
    lens
    memoize
    split
    unordered-containers
    utf8-string
    vector
    (self.callCabal2nix "lib" ./lib {})
  ];
}
