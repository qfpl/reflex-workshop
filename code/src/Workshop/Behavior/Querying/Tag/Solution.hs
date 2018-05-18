{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
module Workshop.Behavior.Querying.Tag.Solution (
    tagSolution
  ) where

import Reflex

tagSolution :: Reflex t
            => Behavior t Int
            -> Event t ()
            -> Event t Int
tagSolution bIn eIn =
  tag ((\b -> b * 5) <$> bIn) eIn
  -- (\b -> b * 5) <$> tag bIn eIn
  -- (\b -> b * 5) <$> bIn <@ eIn
  -- (\b _ -> b * 5) <$> bIn <@> eIn
  -- attachWith (\b _ -> b * 5) bIn eIn
  -- attachWithMaybe (\b _ -> Just (b * 5)) bIn eIn
