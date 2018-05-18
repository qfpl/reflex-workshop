{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE RecursiveDo #-}
module Workshop.Behavior.Creating.Counter.Solution (
    counterSolution
  ) where

import Control.Monad.Fix (MonadFix)
import Data.Function ((&))

import Reflex

counterSolution :: (Reflex t, MonadFix m, MonadHold t m)
                => Event t (Int -> Int)
                -> m (Behavior t Int, Event t Int)
counterSolution eFn = mdo
  let e = flip ($) <$> b <@> eFn
  b <- hold 0 e
  -- b <- hold 0 $ (&) <$> b <@> e
  pure (b, e)
