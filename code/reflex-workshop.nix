{ mkDerivation, aeson, base, bytestring, containers, dependent-map
, dependent-sum, directory, errors, filepath, ghcjs-dom, hashable
, http-api-data, http-types, jsaddle, jsaddle-warp, lens, mtl
, pandoc, reflex, reflex-basic-host, reflex-dom-core, reflex-model
, reflex-server-servant, reflex-server-wai, servant, servant-reflex
, servant-server, stdenv, stm, text, time, transformers, ttrie, wai
, wai-app-static, wai-middleware-static, warp, websockets
}:
mkDerivation {
  pname = "reflex-workshop";
  version = "0.1.0.0";
  src = ./.;
  libraryHaskellDepends = [
    aeson base bytestring containers dependent-map dependent-sum
    directory errors filepath ghcjs-dom hashable http-api-data
    http-types jsaddle jsaddle-warp lens mtl pandoc reflex
    reflex-basic-host reflex-dom-core reflex-model
    reflex-server-servant reflex-server-wai servant servant-reflex
    servant-server stm text time transformers ttrie wai wai-app-static
    wai-middleware-static warp websockets
  ];
  license = stdenv.lib.licenses.bsd3;
}
