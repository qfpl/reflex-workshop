{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
module Workshop.Behavior.Instances.Fmap.Solution (
    fmapSolution
  ) where

import Reflex

fmapSolution :: Reflex t
             => Behavior t Int
             -> Behavior t Int
fmapSolution bIn =
  (* 5) <$> bIn
