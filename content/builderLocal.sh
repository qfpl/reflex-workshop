#!/usr/bin/env bash

source $stdenv/setup
PATH=$processor/bin:$PATH

export LANG=en_US.UTF-8

cd $src
mkdir $out

cp -r $src/assets/* $out/

processor $src/pages $out/pages
