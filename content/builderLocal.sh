#!/usr/bin/env bash

source $stdenv/setup
PATH=$processor/bin:$PATH

cd $src
mkdir $out

cp -r $src/assets/* $out/

processor $src/pages $out/pages
