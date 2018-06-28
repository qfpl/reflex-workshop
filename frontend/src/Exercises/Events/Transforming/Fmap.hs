{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
module Exercises.Events.Transforming.Fmap (
    fmapExercise
  ) where

import Reflex

fmapExercise :: Reflex t => Event t Int -> Event t Int
fmapExercise eIn =
  never
