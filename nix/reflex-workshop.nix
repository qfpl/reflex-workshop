let  
  initialNixpkgs = import <nixpkgs> {};

  sources = rec {
    reflex-workshop-info-pinned = initialNixpkgs.pkgs.lib.importJSON ./reflex-workshop.json;
    reflex-workshop = initialNixpkgs.pkgs.fetchFromGitHub {
      owner = "qfpl";
      repo = "reflex-workshop";
      inherit (reflex-workshop-info-pinned) rev sha256;
    };
  };
in
  sources.reflex-workshop

