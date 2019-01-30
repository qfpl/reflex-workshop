{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
module Workshop (
    workshop
  ) where

import Types.Section

import Workshop.Events
import Workshop.Behaviors
import Workshop.DOM
import Workshop.Collections

workshop :: Sections
workshop = Sections [
    eventsSection
  , behaviorsSection
  , domSection
  , collectionsSection
  ]
