{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecursiveDo #-}
{-# LANGUAGE TemplateHaskell #-}
module Workshop.DOM.Inputs.TextInput.Common (
    TodoItem(..)
  , todoItem_complete
  , todoItem_text
  ) where

import Control.Lens

import Data.Text (Text)

data TodoItem =
  TodoItem {
    _todoItem_complete :: Bool
  , _todoItem_text     :: Text
  }

makeLenses ''TodoItem
