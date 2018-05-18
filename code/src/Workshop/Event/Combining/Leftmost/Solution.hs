{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
module Workshop.Event.Combining.Leftmost.Solution (
    leftmostSolution
  ) where

import Data.Monoid

import Data.Text (Text)
import qualified Data.Text as Text

import Reflex

leftmostSolution :: Reflex t
                 => Event t Int
                 -> ( Event t Text
                    , Event t Text
                    , Event t Text
                    , Event t Text
                    )
leftmostSolution eIn =
  let
    multiple n = (== 0) . (`mod` n)
    eFizz = "Fizz" <$ ffilter (multiple 3) eIn
    eBuzz = "Buzz" <$ ffilter (multiple 5) eIn
    eFizzBuzz = eFizz <> eBuzz
    tshow = Text.pack . show
    eSolution = leftmost [eFizzBuzz, tshow <$> eIn]
  in
    (eFizz, eBuzz, eFizzBuzz, eSolution)

