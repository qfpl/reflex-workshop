{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE DeriveGeneric #-}
module Types.RouteFragment (
    RouteFragment(..)
  , toSegments
  , fromSegments
  , routeToText
  ) where

import Data.Semigroup ((<>))
import GHC.Generics

import Control.Lens

import Data.Text (Text)
import qualified Data.Text as Text

import Data.Aeson (ToJSON, FromJSON)

import Reflex.Dom.Routing.Nested
import URI.ByteString

data RouteFragment =
  Page Text
  deriving (Eq, Ord, Show, Generic)

instance ToJSON RouteFragment where
instance FromJSON RouteFragment where

toSegments :: URIRef a -> [RouteFragment]
toSegments =
  fmap Page .
  nullTextToEmptyList .
  Text.splitOn "/" .
  Text.dropAround (== '/') .
  fragAsText
 where
   nullTextToEmptyList [""] = []
   nullTextToEmptyList x = x

fromSegments :: URIRef a -> [RouteFragment] -> URIRef a
fromSegments u =
  setFrag u . routeToText

routeToText :: [RouteFragment]
            -> Text
routeToText =
  Text.intercalate "/" .
  fmap routeFragmentToText

routeFragmentToText :: RouteFragment
                    -> Text
routeFragmentToText (Page t) =
  t
