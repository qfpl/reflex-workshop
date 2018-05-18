{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
module Workshop.Event.Transforming.FmapConst.Solution (
    fmapConstSolution3
  , fmapConstSolution5
  ) where

import Reflex

fmapConstSolution3 :: Reflex t => Event t () -> Event t Int
fmapConstSolution3 eIn =
  3 <$ eIn

fmapConstSolution5 :: Reflex t => Event t () -> Event t Int
fmapConstSolution5 eIn =
  5 <$ eIn
