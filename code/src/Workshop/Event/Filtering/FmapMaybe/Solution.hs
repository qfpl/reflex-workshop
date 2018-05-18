{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
module Workshop.Event.Filtering.FmapMaybe.Solution (
    fmapMaybeSolution
  ) where

import Control.Monad (void)
import Data.Maybe (isNothing)
import Text.Read (readMaybe)
import Control.Error (note)

import Data.Text (Text)
import qualified Data.Text as Text

import Reflex

convert :: Text -> Maybe Int
convert = readMaybe . Text.unpack

fmapMaybeSolution :: Reflex t => Event t Text -> (Event t Text, Event t Int)
fmapMaybeSolution eIn =
  let
    -- eMaybe =
    --   convert <$> eIn
    -- eOut =
    --   fmapMaybe id eMaybe
    -- eError =
    --   "Not an Int" <$ ffilter isNothing eMaybe

    -- eOut =
    --   fmapMaybe convert eIn
    -- eError =
    --   "Not an Int" <$ difference (void eIn) (void eOut)

    (eError, eOut) =
      fanEither $ note "Not an Int" . convert <$> eIn
  in
    (eError, eOut)
