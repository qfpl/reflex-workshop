{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE RecursiveDo #-}
module Workshop.Behavior.Dynamics.Counter.Solution (
    counterSolution
  ) where

import Control.Monad.Fix (MonadFix)
import Data.Function ((&))

import Reflex

counterSolution :: (Reflex t, MonadFix m, MonadHold t m)
                => Event t (Int -> Int)
                -> m (Dynamic t Int)
counterSolution eFn = mdo
  let e = (&) <$> current d <@> eFn
  d <- holdDyn 0 e
  pure d
  -- foldDyn ($) 0 eFn
  -- accum (&) 0 eFn
