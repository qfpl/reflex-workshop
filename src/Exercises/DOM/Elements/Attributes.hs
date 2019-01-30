{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE GADTs #-}
module Exercises.DOM.Elements.Attributes (
    attributesExercise
  ) where

import Data.Bool
import Data.Monoid

import Reflex.Dom.Core

attributesExercise :: MonadWidget t m
                   => Dynamic t Bool
                   -> m a
                   -> m a
attributesExercise dIn w =
  w
