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

data Section m = Section {
    sectionName :: Text
  , sectionSubsections :: [SubSection m]
  }

data SubSection m = SubSection {
    subSectionName :: Text
  , subSectionContent :: m ()
  }



