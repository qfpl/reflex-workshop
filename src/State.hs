{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE GADTs #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE MultiParamTypeClasses #-}
module State (
    AppTags(..)
  ) where

import Data.Functor.Identity

import Data.Aeson (toJSON, parseJSON)
import Data.Dependent.Map (Some(..))
import Data.GADT.Compare

import Data.GADT.Aeson

import State.Exercise

data AppTags a where
  ExerciseTag :: AppTags ExerciseState

instance GEq AppTags where
  geq ExerciseTag ExerciseTag = Just Refl

instance GCompare AppTags where
  gcompare ExerciseTag ExerciseTag = GEQ

instance GKey AppTags where
  toKey (This ExerciseTag) = "exercise-state"
  fromKey k = case k of
    "exercise-state" -> Just (This ExerciseTag)
    _ -> Nothing
  keys _ = [This ExerciseTag]

instance FromJSONTag AppTags Identity where
  parseJSONTagged ExerciseTag = parseJSON

instance ToJSONTag AppTags Identity where
  toJSONTagged ExerciseTag = toJSON
