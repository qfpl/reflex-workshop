let  
  initialNixpkgs = import <nixpkgs> {};

  sources = rec {
    servant-reflex-info-pinned = initialNixpkgs.pkgs.lib.importJSON ./servant-reflex.json;
    servant-reflex = initialNixpkgs.pkgs.fetchFromGitHub {
      owner = "imalsogreg";
      repo = "servant-reflex";
      inherit (servant-reflex-info-pinned) rev sha256;
    };
  };
in
  sources.servant-reflex

