#!/usr/bin/env bash

source $stdenv/setup
PATH=$nix/bin:$processor/bin:$PATH

export LANG=en_US.UTF-8

cd $src
mkdir $out

processor $src/pages $out/pages

mkdir $out/fonts
cp -r $src/assets/fonts/* $out/fonts/

for f in $(find $out/pages -type f); do
  mv $f $(dirname $f)/$(nix-hash --type sha256 --flat --base32 $f)-$(basename $f)
done

mkdir $out/css
for f in $(find $src/assets/css -type f); do
  cp $f $out/css/$(nix-hash --type sha256 --flat --base32 $f)-$(basename $f)
done

mkdir $out/js
for f in $(find $src/assets/js -type f); do
  cp $f $out/js/$(nix-hash --type sha256 --flat --base32 $f)-$(basename $f)
done



