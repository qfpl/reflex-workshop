{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE RecursiveDo #-}
module Solutions.Behaviors.Creating.Limit (
    limitSolution
  ) where

import Control.Monad.Fix (MonadFix)

import Reflex

limitSolution :: (Reflex t, MonadFix m, MonadHold t m)
              => Behavior t Int
              -> Event t ()
              -> Event t ()
              -> m (Behavior t Int)
limitSolution bCount eAdd eReset = mdo
  let
    defaultLimit = 5

    bLimitIncrease = (==) <$> bCount <*> bLimit
    eLimitIncrease = gate bLimitIncrease eReset

    bLimitReset = (== 0) <$> bCount
    eLimitReset = gate bLimitReset eReset

  bLimit <- hold defaultLimit . leftmost $ [
      (+1) <$> bLimit <@ eLimitIncrease
    , defaultLimit    <$ eLimitReset
    ]

  pure bLimit
