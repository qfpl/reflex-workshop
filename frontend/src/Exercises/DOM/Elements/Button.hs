{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
module Exercises.DOM.Elements.Button (
    buttonExercise
  ) where

import Reflex.Dom.Core

import Util.Bootstrap

buttonExercise :: MonadWidget t m
               => m ()
buttonExercise =
  pure ()
