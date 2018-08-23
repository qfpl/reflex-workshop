{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-#LANGUAGE RankNTypes #-}
{-#LANGUAGE GADTs #-}
{-#LANGUAGE TemplateHaskell #-}
module Types.Exercise where

import Control.Lens.TH (makeLenses)

import Data.Map (Map)
import Data.Text (Text)

import Reflex.Dom.Core (Widget)

import Types.Demonstration

data Problem m =
  Problem {
    _pPage :: Text
  , _pExerciseFile :: Text
  , _pDemonstrations :: Map Text (Demonstration m)
  }

makeLenses ''Problem

data Progress m where
  ProgressNoSetup :: m () -> m () -> Progress m
  ProgressSetup :: Bool -> m a -> (a -> m ()) -> (a -> m ()) -> Progress m

data Solution =
  Solution {
    _sPages :: [Text]
  }

makeLenses ''Solution

data Exercise m =
  Exercise {
    _eName     :: Text
  , _eId       :: Text
  , _eProblem  :: Problem m
  , _eProgress :: Progress m
  , _eSolution :: Solution
  }

makeLenses ''Exercise
