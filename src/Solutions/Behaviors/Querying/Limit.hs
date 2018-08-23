{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
module Solutions.Behaviors.Querying.Limit (
    limitSolution
  ) where

import Reflex

import Solutions.Behaviors.Querying.Counter

limitSolution :: Reflex t
              => Behavior t Int
              -> Behavior t Int
              -> Event t ()
              -> Event t ()
              -> Event t Int
limitSolution bCount bLimit eAdd eReset =
  let
    bAtLimit = (<) <$> bCount <*> bLimit
    eAddOK   = gate bAtLimit eAdd
  in
    counterSolution bCount eAddOK eReset

