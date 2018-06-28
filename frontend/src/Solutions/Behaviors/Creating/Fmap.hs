{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
module Solutions.Behaviors.Creating.Fmap (
    fmapSolution
  ) where

import Reflex

fmapSolution :: (Reflex t, MonadHold t m)
             => Event t Int
             -> m (Behavior t Int)
fmapSolution eIn =
  hold 0 eIn
