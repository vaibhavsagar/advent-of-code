let
  fetch    = (import <nixpkgs> {}).fetchFromGitHub;
  # ./updater versions.json ihaskell
  IHaskell = fetch (builtins.fromJSON (builtins.readFile ./versions.json)).ihaskell;
  # ./updater versions.json nixpkgs nixos-17.09
  pinned   = fetch (builtins.fromJSON (builtins.readFile ./versions.json)).nixpkgs;
  nixpkgs  = import pinned {};
  my-lib   = nixpkgs.haskell.lib.dontHaddock (nixpkgs.haskellPackages.callCabal2nix "lib" ./lib {});
in import "${IHaskell}/release.nix" {
  inherit nixpkgs;
  packages = self: with self; [
    attoparsec
    bytestring
    containers
    directory
    filepath
    my-lib
    split
    utf8-string
  ];
}
