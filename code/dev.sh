#!/usr/bin/env bash
ghcid --command="ghci -ghci-script=./dev.ghci" -W --test="main" --reload=./assets/css/style.css --reload=../pages
