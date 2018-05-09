{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
module Util.Section (
    Section(..)
  , SubSection(..)
  ) where

import Data.Text (Text)

import Reflex

import Util.WorkshopState

data Section t m = Section {
    sectionName :: Text
  , sectionSubsections :: [SubSection t m]
  }

data SubSection t m = SubSection {
    subSectionName :: Text
  , subSectionContent :: Dynamic t ExerciseState -> m (Event t ExerciseState)
  }



