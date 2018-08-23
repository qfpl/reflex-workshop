{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
module Exercises.Events.Combining.MergeWith (
    mergeWithExercise
  ) where

import Data.Monoid

import Reflex

mergeWithExercise :: Reflex t
                  => Event t Int
                  -> Event t Int
                  -> Event t Int
mergeWithExercise eIn1 eIn2 =
  never
