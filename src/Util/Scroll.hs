{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
module Util.Scroll (
    scrollTo
  ) where

import Data.Foldable (forM_)

import Data.Text (Text)

import Reflex.Dom.Core

import GHCJS.DOM.NonElementParentNode (getElementById)
import GHCJS.DOM.Element (scrollIntoView)

scrollTo :: MonadWidget t m
         => Text
         -> m ()
scrollTo i = do
  doc <- askDocument
  me <- getElementById doc i
  forM_ me $ \e ->
    scrollIntoView e True
