{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
module Workshop.DOM.Switching.HigherOrder.Exercise (
    higherOrderExercise
  ) where

import Data.Bool

import Control.Monad.Fix (MonadFix)

import Reflex.Dom.Core

higherOrderExercise :: (Reflex t, MonadFix m, MonadHold t m)
                    => Event t Bool
                    -> Event t ()
                    -> m (Dynamic t Int)
higherOrderExercise eClickable eClick =
  pure (pure 0)
