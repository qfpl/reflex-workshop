{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
module Util.Bootstrap (
    card
  , dynButtonDynAttr
  , dynButtonAttr
  , dynButtonDynClass
  , dynButtonClass
  , buttonDynAttr
  , buttonAttr
  , buttonDynClass
  , buttonClass
  ) where

import Data.Monoid

import Data.Text (Text)
import Data.Map (Map)

import Reflex.Dom.Core

card :: MonadWidget t m => m a -> m a
card =
  divClass "card m-2" . divClass "card-body"

dynButtonDynAttr :: MonadWidget t m => Dynamic t Text -> Dynamic t (Map Text Text) -> m (Event t ())
dynButtonDynAttr dLabel dAttrs = do
  let attrs = "type" =: "button"
  (e, _) <- elDynAttr' "button" (pure attrs <> dAttrs) $ dynText dLabel
  pure $ domEvent Click e

dynButtonAttr :: MonadWidget t m => Dynamic t Text -> Map Text Text -> m (Event t ())
dynButtonAttr dLabel attr =
  dynButtonDynAttr dLabel (pure attr)

dynButtonDynClass :: MonadWidget t m => Dynamic t Text -> Dynamic t Text -> m (Event t ())
dynButtonDynClass dLabel dClass =
  dynButtonDynAttr dLabel $ ("class" =:) <$> dClass

dynButtonClass :: MonadWidget t m => Dynamic t Text -> Text -> m (Event t ())
dynButtonClass dLabel clss =
  dynButtonDynClass dLabel (pure clss)

buttonDynAttr :: MonadWidget t m => Text -> Dynamic t (Map Text Text) -> m (Event t ())
buttonDynAttr label =
  dynButtonDynAttr (pure label)

buttonAttr :: MonadWidget t m => Text -> Map Text Text -> m (Event t ())
buttonAttr label =
  dynButtonAttr (pure label)

buttonDynClass :: MonadWidget t m => Text -> Dynamic t Text -> m (Event t ())
buttonDynClass label =
  dynButtonDynClass (pure label)

buttonClass :: MonadWidget t m => Text -> Text -> m (Event t ())
buttonClass label =
  dynButtonClass (pure label)
