let  
  initialNixpkgs = import <nixpkgs> {};

  sources = rec {
    reflex-model-info-pinned = initialNixpkgs.pkgs.lib.importJSON ./reflex-model.json;
    reflex-model = initialNixpkgs.pkgs.fetchFromGitHub {
      owner = "dalaing";
      repo = "reflex-model";
      inherit (reflex-model-info-pinned) rev sha256;
    };
  };
in
  sources.reflex-model

