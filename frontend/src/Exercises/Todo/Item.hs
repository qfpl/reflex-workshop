{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecursiveDo #-}
module Exercises.Todo.Item where

import Control.Monad
import Data.Bool
import Data.Monoid

import Control.Lens

import Data.Text (Text)
import qualified Data.Text as Text

import Data.Map (Map)
import qualified Data.Map as Map

import Reflex.Dom.Core

import Common.Todo

todoItem :: MonadWidget t m
         => TodoItem
         -> m (Event t ())
todoItem ti = do
  pure never

todoItemExercise :: MonadWidget t m
                 => TodoItem
                 -> m ()
todoItemExercise ti =
  pure ()
