{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
module Workshop.Event.Combining.MergeWith.Solution (
    mergeWithSolution
  ) where

import Data.Monoid

import Reflex

mergeWithSolution :: Reflex t
                  => Event t Int
                  -> Event t Int
                  -> Event t Int
mergeWithSolution eIn1 eIn2 =
  mergeWith (+) [eIn1, eIn2]
  -- getSum <$> (Sum <$> eIn1) <> (Sum <$> eIn2)
