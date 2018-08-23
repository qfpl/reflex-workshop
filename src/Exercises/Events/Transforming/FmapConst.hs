{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
module Exercises.Events.Transforming.FmapConst (
    fmapConstExercise3
  , fmapConstExercise5
  ) where

import Reflex

fmapConstExercise3 :: Reflex t => Event t () -> Event t Int
fmapConstExercise3 eIn =
  never

fmapConstExercise5 :: Reflex t => Event t () -> Event t Int
fmapConstExercise5 eIn =
  never
