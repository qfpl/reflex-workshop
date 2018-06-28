{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE DeriveGeneric #-}
module State.Exercise where

import GHC.Generics (Generic)

import Data.Aeson (ToJSON, FromJSON)
import Data.Text (Text)

import Control.Lens

import Types.RouteFragment

data ExerciseStage =
    StageHidden
  | StageProblem
  | StageProgress
  | StageSolution Int
  deriving (Eq, Ord, Show, Generic)

makePrisms ''ExerciseStage

instance ToJSON ExerciseStage where
instance FromJSON ExerciseStage where

data ExerciseState =
  ExerciseState {
    esId :: Text
  , esStage :: ExerciseStage
  } deriving (Eq, Ord, Show, Generic)

instance ToJSON ExerciseState where
instance FromJSON ExerciseState where
