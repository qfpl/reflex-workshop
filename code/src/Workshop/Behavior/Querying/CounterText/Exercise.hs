{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
module Workshop.Behavior.Querying.CounterText.Exercise (
    counterTextExercise
  ) where

import Data.Text (Text)

import Reflex

import Workshop.Event.Filtering.FmapMaybe.Exercise
import Workshop.Behavior.Querying.Counter.Exercise

counterTextExercise :: Reflex t
                    => Behavior t Int
                    -> Behavior t Text
                    -> Event t ()
                    -> Event t ()
                    -> (Event t Text, Event t Int)
counterTextExercise bCount bText eAdd eReset =
  (never, never)
