{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
module Workshop.Event.Combining.Leftmost.Exercise (
    leftmostExercise
  ) where

import Data.Monoid

import Data.Text (Text)
import qualified Data.Text as Text

import Reflex

leftmostExercise :: Reflex t
                 => Event t Int
                 -> ( Event t Text
                    , Event t Text
                    , Event t Text
                    , Event t Text
                    )
leftmostExercise eIn =
  (never, never, never, never)
