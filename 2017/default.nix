let
  fetch    = (import <nixpkgs> {}).fetchFromGitHub;
  # ./updater versions.json ihaskell
  IHaskell = fetch (builtins.fromJSON (builtins.readFile ./versions.json)).ihaskell;
  # ./updater versions.json nixpkgs nixos-17.09
  pinned   = fetch (builtins.fromJSON (builtins.readFile ./versions.json)).nixpkgs;
  my-lib   = (import pinned {}).pkgs.haskellPackages.callCabal2nix "lib" ./lib {};
in import "${IHaskell}/release.nix" {
  nixpkgs = import pinned {};
  packages = self: with self; [
    attoparsec
    bytestring
    containers
    directory
    filepath
    my-lib
    utf8-string
  ];
}
