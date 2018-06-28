{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
module Exercises.Behaviors.Querying.Tag (
  tagExercise
  ) where

import Reflex

tagExercise :: Reflex t
            => Behavior t Int
            -> Event t ()
            -> Event t Int
tagExercise bIn eIn =
  never
