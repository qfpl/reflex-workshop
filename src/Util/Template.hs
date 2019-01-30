{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE GADTs #-}
module Util.Template (
    mkTemplate
  ) where

import Data.Semigroup ((<>))

import qualified Data.Map as Map
import Data.Text (Text)

import Reflex.Dom.Core
import Reflex.Dom.Template

import Util.Bootstrap

mkTemplate :: MonadWidget t m => Rule m -> Text -> m (Event t ())
mkTemplate rule t = do
  ePostBuild <- getPostBuild
  eTemplate <- loadTemplate (rule <> sourceCodeRule) (t <$ ePostBuild)
  let
    (eError, eSuccess) = fanEither eTemplate
    loadingDiv = divClass "alert alert-secondary" $ text "Loading..." >> getPostBuild
    errorDiv = divClass "alert alert-error" $ text "Error loading page" >> getPostBuild
    wrapPostBuild w = w >> getPostBuild
  fmap switchDyn . widgetHold loadingDiv . leftmost $ [wrapPostBuild <$> eSuccess, errorDiv <$ eError]

sourceCodeRule :: MonadWidget t m => Rule m
sourceCodeRule =
  Rule $ \l childFn ->
    case l of
      RTElement t a es ->
        case t of
          "div" -> do
            cls <- Map.lookup "class" a
            case cls of
              "sourceCode" -> Just . card . divClass "sourceCode" $ childFn es
              _ -> Nothing
          _ -> Nothing
      _ -> Nothing
