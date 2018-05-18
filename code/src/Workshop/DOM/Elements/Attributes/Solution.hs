{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
module Workshop.DOM.Elements.Attributes.Solution (
    attributesSolution
  ) where

import Data.Bool
import Data.Monoid

import Reflex.Dom.Core

attributesSolution :: MonadWidget t m
                   => Dynamic t Bool
                   -> m a
                   -> m a
attributesSolution dIn w = do
  -- let
  --  attrs = "class" =: "text-uppercase"
  -- elAttr "div" attrs $
  --   w

  -- let
  --   dAttrs = bool mempty ("hidden" =: "") <$> dIn
  -- elDynAttr "div" dAttrs $
  --   w

  let
    dAttrs = bool mempty ("hidden" =: "") <$> dIn
    attrs = "class" =: "text-uppercase"
  elDynAttr "div" (pure attrs <> dAttrs) $
    w
