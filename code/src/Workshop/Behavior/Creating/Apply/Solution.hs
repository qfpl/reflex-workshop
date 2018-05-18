{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
module Workshop.Behavior.Creating.Apply.Solution (
    applySolution
  ) where

import Reflex

applySolution :: (Reflex t, MonadHold t m)
              => Event t Int
              -> m (Behavior t Int, Behavior t Int)
applySolution eIn = do
  let
    multiple n =
      (== 0) . (`mod` n)
    downsample n =
      fmap (`div` n) . ffilter (multiple n)
  b2 <- hold 0 $ downsample 2 eIn
  b3 <- hold 0 $ downsample 3 eIn
  pure (b2, b3)
