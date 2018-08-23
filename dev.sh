#!/usr/bin/env bash
ghcid --command="ghci -ghci-script=dev.ghci" -W --test="run" --reload=./assets
