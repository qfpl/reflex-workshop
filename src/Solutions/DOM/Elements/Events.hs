{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE GADTs #-}
module Solutions.DOM.Elements.Events (
    eventsSolution
  ) where

import Data.Bool

import Reflex.Dom.Core

eventsSolution :: MonadWidget t m
               => Dynamic t Bool
               -> m a
               -> m (Event t ())
eventsSolution dIn w = do
  let
    dAttrs = bool mempty ("hidden" =: "") <$> dIn
    attrs = "class" =: "text-uppercase"
  (e, _) <- elDynAttr' "div" (pure attrs <> dAttrs) $
    w
  pure $ domEvent Click e
