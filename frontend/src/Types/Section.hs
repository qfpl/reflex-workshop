{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE TemplateHaskell #-}
module Types.Section where

import Data.Text (Text)
import Data.Map (Map)

import Reflex.Dom.Core (MonadWidget)

import Control.Lens.TH (makeLenses)

import Types.Demonstration
import Types.Exercise
import Types.RouteFragment (RouteFragment)

data Section m =
  Section {
    _sName           :: Text
  , _sRoute          :: RouteFragment
  , _sContentPath    :: Text
  , _sSubSections    :: [Section m]
  , _sDemonstrations :: Map Text (Demonstration m)
  , _sExercises      :: Map Text (Exercise m)
  }

makeLenses ''Section

newtype Sections = Sections { unSections :: forall t m. MonadWidget t m => [Section m] }
