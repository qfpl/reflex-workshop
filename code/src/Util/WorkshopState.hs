{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE TemplateHaskell #-}
module Util.WorkshopState (
    WorkshopState(..)
  , initialWorkshopState
  , wsIndex
  , wsExercises
  , ExerciseState(..)
  , initialExerciseState
  , Selected(..)
  , _Goal
  , _Exercise
  , _Solution
  , _Done
  ) where

import GHC.Generics (Generic)

import Control.Lens

import Data.Map (Map)
import qualified Data.Map as Map

import Data.IntMap (IntMap)
import qualified Data.IntMap as IntMap

import Data.Aeson

data Selected =
    Goal
  | Exercise
  | Solution Int
  | Done
  deriving (Eq, Ord, Show, Read, Generic)

makePrisms ''Selected

instance ToJSON Selected where
instance FromJSON Selected where

newtype ExerciseState =
  ExerciseState {
    getExerciseState :: IntMap Selected
  } deriving (Eq, Ord, Show, Read, Generic)

makeWrapped ''ExerciseState

instance ToJSON ExerciseState
instance FromJSON ExerciseState

initialExerciseState :: ExerciseState
initialExerciseState = ExerciseState IntMap.empty

data WorkshopState =
  WorkshopState {
    _wsIndex :: (Int, Int)
  , _wsExercises :: Map (Int, Int) ExerciseState
  } deriving (Eq, Ord, Show, Read, Generic)

makeLenses ''WorkshopState

initialWorkshopState :: WorkshopState
initialWorkshopState = WorkshopState (0, 0) Map.empty

instance ToJSON WorkshopState where
instance FromJSON WorkshopState where
