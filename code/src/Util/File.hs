{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE RankNTypes #-}
module Util.File (
    loadMarkdown
  , loadMarkdownSplices
  ) where

import Control.Monad (forM_)
import Data.Maybe (fromMaybe)
import Data.List (break, span, isPrefixOf)

import Data.Text (Text)

import Data.Map (Map)
import qualified Data.Map as Map

import Text.Pandoc

import Control.Monad.Trans (liftIO)

import Reflex.Dom.Core hiding (Element)
import GHCJS.DOM.Element (Element, setInnerHTML)
import Language.Javascript.JSaddle.Monad (MonadJSM, liftJSM)

stringDiv :: MonadWidget t m
          => String
          -> m ()
stringDiv contents = do
  (e, _) <- el' "div" $ pure ()
  setInnerHTML (_element_raw e) contents

markdownToHtml :: String -> String
markdownToHtml cm =
  case readMarkdown def cm of
    Left e -> show e
    Right x -> writeHtmlString (def {writerHighlight = True}) x

loadMarkdown :: MonadWidget t m
             => FilePath
             -> m ()
loadMarkdown fp = do
  s <- liftIO $ readFile fp
  stringDiv $ markdownToHtml s

separator :: String -> Bool
separator = isPrefixOf "==="

separate :: [String] -> (String, [String])
separate s =
  let
    (a, b) = break separator s
    (_, c) = span  separator b
  in
    (unlines a, c)

groupSplices :: [String] -> [Either String String]
groupSplices = groupSplicesMd
  where
    groupSplicesMd [] = []
    groupSplicesMd s =
      let
        (a, c) = separate s
      in
        Left a : groupSplicesSplice c
    groupSplicesSplice [] = []
    groupSplicesSplice s =
      let
        (a, c) = separate s
      in
        Right (init a) : groupSplicesMd c

loadMarkdownSplices :: MonadWidget t m
                    => FilePath
                    -> m [m ()]
loadMarkdownSplices fp = do
  s <- liftIO $ readFile fp
  pure $ (groupSplices (lines s)) >>= \x ->
    case x of
      Left l -> pure $ stringDiv (markdownToHtml l)
      Right _ -> []
