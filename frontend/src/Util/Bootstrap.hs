{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeApplications #-}
{-# LANGUAGE DataKinds #-}
module Util.Bootstrap (
    mkApp
  , card
  , dynButtonDynAttr
  , dynButtonAttr
  , dynButtonDynClass
  , dynButtonClass
  , buttonDynAttr
  , buttonAttr
  , buttonDynClass
  , buttonClass
  ) where

import Reflex.Dom
import Static

import Data.Foldable (traverse_)
import Data.Semigroup ((<>))

import Data.Text (Text)

import Data.Map (Map)
import qualified Data.Map as Map

bootstrapCssFiles :: [Text]
bootstrapCssFiles = [
    static @"css/bootstrap.min.css"
  , static @"css/font-awesome.min.css"
  , static @"css/style.css"
  , static @"css/syntax.css"
  ]

bootstrapJsFiles :: [Text]
bootstrapJsFiles = [
    static @"js/jquery-3.2.1.slim.min.js"
  , static @"js/popper.min.js"
  , static @"js/bootstrap.min.js"
  ]

headSection :: [Text] -> StaticWidget x ()
headSection cssFiles = do
  el "title" $ text "Reflex workshop"
  elAttr "meta" ("charset" =: "utf-8") blank
  elAttr "meta" ("name" =: "viewport" <>
                 "content" =: "width=device-width, initial-scale=1, shrink-to-fit=no") blank
  let
    stylesheet s =
      elAttr "link" (Map.fromList [("rel", "stylesheet"), ("href", s)]) blank
  traverse_ stylesheet $ bootstrapCssFiles ++ cssFiles

tailSection :: [Text] -> Widget x ()
tailSection jsFiles =
  let
    script src =
      elAttr "script" ("src" =: src) blank
  in
    traverse_ script $ bootstrapJsFiles ++ jsFiles

mkApp :: [Text] -> [Text] -> Widget x () -> (StaticWidget x (), Widget x ())
mkApp cssFiles jsFiles w = (headSection cssFiles, w >> tailSection jsFiles)

card :: MonadWidget t m => m a -> m a
card = divClass "card m-2" . divClass "card-body"

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
