{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE RecursiveDo #-}
module Solutions.Behaviors.Creating.Text (
    textSolution
  ) where

import Control.Monad.Fix (MonadFix)

import Data.Text (Text)

import Reflex

textSolution :: (Reflex t, MonadFix m, MonadHold t m)
             => Behavior t Int
             -> Event t Text
             -> m (Behavior t [Text], Event t [Text])
textSolution bIn eIn = mdo
  let
    add n xs x = take n (x : xs)
    e = add <$> bIn <*> b <@> eIn
  b <- hold [] e
  pure (b, e)
