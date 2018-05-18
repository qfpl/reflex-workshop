{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
module Workshop.DOM.Switching.HigherOrder.Solution (
    higherOrderSolution
  ) where

import Data.Bool (bool)

import Control.Monad.Fix (MonadFix)

import Reflex.Dom.Core

higherOrderSolution :: (Reflex t, MonadFix m, MonadHold t m)
                    => Event t Bool
                    -> Event t ()
                    -> m (Dynamic t Int)
higherOrderSolution eClickable eClick = do
  let
    eReset = const 0 <$ eClick
    eAdd   = (+ 1)   <$ eClick

    eeMode = bool eReset eAdd <$> eClickable

  {-
  eScore <- switchHold eReset eeMode
  -}

  deScore <- holdDyn eReset eeMode
  let
    eScore = switchDyn deScore

  foldDyn ($) 0 eScore
