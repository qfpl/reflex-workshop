{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
module Workshop.Behavior.Querying.Counter.Solution (
    counterSolution'
  , counterSolution
  ) where

import Reflex

counterSolution' :: Reflex t
                 => Behavior t Int
                 -> Event t Int
                 -> Event t ()
                 -> Event t Int
counterSolution' bCount eAdd eReset =
  leftmost [
      0   <$  eReset
    , (+) <$> bCount <@> eAdd
    ]

counterSolution :: Reflex t
                => Behavior t Int
                -> Event t ()
                -> Event t ()
                -> Event t Int
counterSolution bCount eAdd eReset =
  counterSolution' bCount (1 <$ eAdd) eReset
  -- leftmost [
  --    0   <$  eReset
  --  , (+ 1) <$> bCount <@ eAdd
  --  ]

counterSolutionAlt :: Reflex t
                   => Event t Int
                   -> Event t ()
                   -> Event t (Int -> Int)
counterSolutionAlt eAdd eReset =
  leftmost [
      const 0 <$  eReset
    , (+)     <$> eAdd
    ]
