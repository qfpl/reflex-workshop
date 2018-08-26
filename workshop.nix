{ mkDerivation, aeson, base, bytestring, containers, dependent-map
, dependent-sum, errors, exception-transformers, filepath
, ghcjs-dom, jsaddle, jsaddle-warp, lens, mtl, ref-tf, reflex
, reflex-dom, reflex-dom-contrib, reflex-dom-nested-routing
, reflex-dom-storage, reflex-dom-template, stdenv, text
, uri-bytestring, wai-app-static
}:
mkDerivation {
  pname = "workshop";
  version = "0.1";
  src = ./.;
  libraryHaskellDepends = [
    aeson base bytestring containers dependent-map dependent-sum errors
    exception-transformers filepath ghcjs-dom jsaddle jsaddle-warp lens
    mtl ref-tf reflex reflex-dom reflex-dom-contrib
    reflex-dom-nested-routing reflex-dom-storage reflex-dom-template
    text uri-bytestring wai-app-static
  ];
  license = stdenv.lib.licenses.unfree;
  hydraPlatforms = stdenv.lib.platforms.none;
}
