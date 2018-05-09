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

import Util.Run
import Util.UI

import Workshop.Demo

main :: IO ()
main =
  run 9090 $
    mkMainPanel [
      demoSection
    ]

