{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
module Solutions.Events.Filtering.Ffilter (
    ffilterSolution
  ) where

import Reflex

ffilterSolution :: Reflex t => Event t Int -> Event t Int
ffilterSolution =
  ffilter ((== 0) . (`mod` 3))
