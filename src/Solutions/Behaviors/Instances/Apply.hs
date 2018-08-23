{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
module Solutions.Behaviors.Instances.Apply (
    applySolution
  ) where

import Reflex

applySolution :: Reflex t
              => Behavior t Int
              -> Behavior t Int
              -> Behavior t Int
applySolution bIn1 bIn2 =
  (*) <$> bIn1 <*> bIn2
