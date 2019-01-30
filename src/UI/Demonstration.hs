{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE GADTs #-}
module UI.Demonstration (
   demonstrationRule
  ) where

import Data.Text (Text)
import qualified Data.Text as Text

import Data.Map (Map)
import qualified Data.Map as Map

import Reflex.Dom.Core
import Reflex.Dom.Template.Rule

import Types.Demonstration

demonstrationRule :: MonadWidget t m => Map Text (Demonstration m) -> Rule m
demonstrationRule m = elIdRule "div" $ \i -> do
  let
    (t1,t2) = Text.breakOn "-" i
    t3 = Text.drop 1 t2
  case t1 of
    "demonstration" -> fmap mkDemonstration . Map.lookup t3 $ m
    _ -> Nothing

mkDemonstration :: MonadWidget t m => Demonstration m -> m ()
mkDemonstration d =
  divClass "card m-2" . divClass "card-body" $
    _dWidget d

