{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
module Workshop (
    main
  ) where

import Workshop.Initial
import Workshop.Event
import Workshop.Behavior
import Workshop.DOM
import Workshop.Collections
import Workshop.EventWriter
import Workshop.Miscellany
import Workshop.Reference

import Util.Run
import Util.UI

main :: IO ()
main =
  run 9090 $ mkMainPanel
    [ initialSection
    , eventSection
    , behaviorSection
    , domSection
    , collectionsSection
    , eventWriterSection
    -- , miscellanySection
    , referenceSection
    ]
