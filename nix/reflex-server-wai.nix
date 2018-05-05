let  
  initialNixpkgs = import <nixpkgs> {};

  sources = rec {
    reflex-server-wai-info-pinned = initialNixpkgs.pkgs.lib.importJSON ./reflex-server-wai.json;
    reflex-server-wai = initialNixpkgs.pkgs.fetchFromGitHub {
      owner = "dalaing";
      repo = "reflex-server-wai";
      inherit (reflex-server-wai-info-pinned) rev sha256;
    };
  };
in
  sources.reflex-server-wai

