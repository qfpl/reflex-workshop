{ nixpkgs ? import <nixpkgs> {}, owner, repo, jsonFile}:
let  
  inherit (nixpkgs) pkgs;

  info-pinned = pkgs.lib.importJSON jsonFile;
  sources = pkgs.fetchFromGitHub {
    inherit owner repo;
    inherit (info-pinned) rev sha256;
  };
in
  sources
