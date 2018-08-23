{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
module Types.Interactivity (
    Interactivity(..)
  , getInteractivity
  ) where

import Data.Bool (bool)
import Text.Read (readMaybe)
import Data.Text (unpack)

data Interactivity =
    Interactive
  | NonInteractive
  deriving (Eq, Ord, Show, Read)

getInteractivity :: IO Interactivity
getInteractivity = pure Interactive


