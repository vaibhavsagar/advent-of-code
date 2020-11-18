let
  fetcher = { owner, repo, rev, sha256, ... }: builtins.fetchTarball {
    inherit sha256;
    url = "https://github.com/${owner}/${repo}/archive/${rev}.tar.gz";
  };
  inherit (import <nixpkgs> {}) lib;
  # ./updater versions.json ihaskell
  # ./updater versions.json nixpkgs nixos-20.09
  versions = lib.mapAttrs
    (_: fetcher)
    (builtins.fromJSON (builtins.readFile ../versions.json));
  nixpkgs  = import versions.nixpkgs {};
  drv = nixpkgs.haskellPackages.callCabal2nix "lib" ./. {};
in
  if lib.inNixShell then drv.env else drv
