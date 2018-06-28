{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-#LANGUAGE RankNTypes #-}
{-#LANGUAGE TemplateHaskell #-}
module Types.Demonstration where

import Control.Lens.TH (makeLenses)

import Data.Text (Text)

import Reflex.Dom.Core (Widget)

data Demonstration m =
  Demonstration {
    _dName :: Text
  , _dWidget :: m ()
  }

makeLenses ''Demonstration
