{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
module Exercises.Behaviors.Instances.Apply (
    applyExercise
  ) where

import Reflex

applyExercise :: Reflex t
              => Behavior t Int
              -> Behavior t Int
              -> Behavior t Int
applyExercise bIn1 bIn2 =
  pure 0
