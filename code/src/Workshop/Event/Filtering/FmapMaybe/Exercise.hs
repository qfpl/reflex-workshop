{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
module Workshop.Event.Filtering.FmapMaybe.Exercise (
    fmapMaybeExercise
  ) where

import Control.Monad
import Data.Maybe
import Text.Read
import Control.Error

import Data.Text (Text)
import qualified Data.Text as Text

import Reflex

convert :: Text -> Maybe Int
convert = readMaybe . Text.unpack

fmapMaybeExercise :: Reflex t => Event t Text -> (Event t Text, Event t Int)
fmapMaybeExercise eIn =
  (never, never)
