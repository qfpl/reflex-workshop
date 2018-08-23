{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
module Solutions.DOM.Elements.Class (
    classSolution
  ) where

import Data.Bool
import Data.Monoid

import Reflex.Dom.Core

classSolution :: MonadWidget t m
              => Dynamic t Bool
              -> m a
              -> m a
classSolution dIn w = do
  -- elClass "div" "text-uppercase" $
  --  w

  -- let
  --   dClass = bool "" "invisible" <$> dIn
  -- elDynClass "div" dClass $
  --  w
  let
    dClass = bool "" " invisible" <$> dIn
  elDynClass "div" ("text-uppercase" <> dClass) $
    w
