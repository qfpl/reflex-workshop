#! /usr/bin/env bash

nix-prefetch-git https://github.com/reflex-frp/reflex-platform refs/heads/develop > reflex-platform/github.json
nix-prefetch-git https://github.com/reflex-frp/reflex-dom-contrib > reflex-dom-contrib/github.json
nix-prefetch-git https://github.com/3noch/reflex-dom-nested-routing > reflex-dom-nested-routing/github.json
nix-prefetch-git https://github.com/qfpl/reflex-dom-storage > reflex-dom-storage/github.json
nix-prefetch-git https://github.com/qfpl/reflex-dom-template > reflex-dom-template/github.json
nix-prefetch-git https://github.com/ghcjs/jsaddle > jsaddle/github.json
