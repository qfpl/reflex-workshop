{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
module Exercises.Behaviors.Instances.Fmap (
    fmapExercise
  ) where

import Reflex

fmapExercise :: Reflex t
             => Behavior t Int
             -> Behavior t Int
fmapExercise bIn =
  pure 0
