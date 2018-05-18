{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
module Workshop.Event.Transforming.Fmap.Solution (
    fmapSolution
  ) where

import Reflex

fmapSolution :: Reflex t => Event t Int -> Event t Int
fmapSolution eIn =
  (* 2) <$> eIn
