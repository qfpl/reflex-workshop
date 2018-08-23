{ nixpkgs ? import <nixpkgs> {}}:
  import ../github.nix { 
    inherit nixpkgs; 
    owner = "ghcjs"; 
    repo = "jsaddle"; 
    jsonFile = ./github.json;
  }

