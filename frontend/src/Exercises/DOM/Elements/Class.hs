{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
module Exercises.DOM.Elements.Class (
    classExercise
  ) where

import Data.Bool
import Data.Monoid

import Reflex.Dom.Core

classExercise :: MonadWidget t m
              => Dynamic t Bool
              -> m a
              -> m a
classExercise dIn w =
  w
