{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
module Workshop.Behavior.Querying.Counter.Exercise (
    counterExercise'
  , counterExercise
  ) where

import Reflex

counterExercise' :: Reflex t
                 => Behavior t Int
                 -> Event t Int
                 -> Event t ()
                 -> Event t Int
counterExercise' bCount eAdd eReset =
  never

counterExercise :: Reflex t
                => Behavior t Int
                -> Event t ()
                -> Event t ()
                -> Event t Int
counterExercise bCount eAdd eReset =
  never
