{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
module Solutions.DOM.Elements.Button (
    buttonSolution
  ) where

import Reflex.Dom.Core

import Util.Bootstrap

buttonSolution :: MonadWidget t m
               => m ()
buttonSolution = do
  eAdd <- el "div" $ button "Add"
  eReset <- el "div" $ button "Reset"
  -- eAdd <- el "div" $ buttonClass "Add" "btn"
  -- eReset <- el "div" $ buttonClass "Reset" "btn"

  let
    eChange =
      mergeWith (.) [
          (+ 1) <$ eAdd
        , const 0 <$ eReset
        ]
  dCount <- foldDyn ($) 0 eChange

  el "div" $
    display dCount
