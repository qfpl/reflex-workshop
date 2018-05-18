{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
module Workshop.Behavior.Dynamics.Unique.Solution (
    uniqueSolution
  ) where

import Control.Monad.Fix (MonadFix)

import Reflex

uniqueSolution :: (Reflex t, MonadFix m, MonadHold t m)
               => Dynamic t (Int, Int)
               -> m (Dynamic t Int, Dynamic t Int)
uniqueSolution dIn = do
  dOut1 <- holdUniqDyn $ fst <$> dIn
  dOut2 <- holdUniqDyn $ snd <$> dIn
  pure (dOut1, dOut2)
