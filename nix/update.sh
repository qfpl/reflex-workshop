#! /usr/bin/env bash

nix-prefetch-git https://github.com/reflex-frp/reflex-platform > reflex-platform.json
nix-prefetch-git https://github.com/imalsogreg/servant-reflex > servant-reflex.json
nix-prefetch-git https://github.com/dalaing/reflex-basic-host > reflex-basic-host.json
nix-prefetch-git https://github.com/dalaing/reflex-model > reflex-model.json
nix-prefetch-git https://github.com/dalaing/reflex-server-servant > reflex-server-servant.json
nix-prefetch-git https://github.com/dalaing/reflex-server-wai > reflex-server-wai.json
nix-prefetch-git https://github.com/qfpl/reflex-workshop > reflex-workshop.json
