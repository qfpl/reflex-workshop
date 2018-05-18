{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
module Workshop.Event.Filtering.Ffilter.Exercise (
    ffilterExercise
  ) where

import Reflex

ffilterExercise :: Reflex t => Event t Int -> Event t Int
ffilterExercise eIn =
  never

