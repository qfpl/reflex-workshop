{ nixpkgs ? import <nixpkgs> {}}:
  import ../github.nix { 
    inherit nixpkgs; 
    owner = "qfpl"; 
    repo = "reflex-dom-template"; 
    jsonFile = ./github.json;
  }

