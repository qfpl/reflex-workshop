{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE MultiParamTypeClasses #-}
module UI (
    ui
  ) where

import Control.Monad (void)

import Reflex.Dom.Core
import Language.Javascript.JSaddle (liftJSM)

import Reflex.Dom.Routing.Writer

import State
import Types.RouteFragment
import Types.Section
import UI.Base
import UI.Menu
import UI.Routing

ui :: forall t m.
      MonadWidget t m
   => Sections
   -> m ()
ui sections = divClass "container-fluid" $ do
  elClass "nav" "navbar navbar-expand navbar-light bg-light" $ do
    void $ linkClass "Reflex Workshop" "navbar-brand"

  divClass "row" . divClass "container-fluid d-flex flex-row" $ runUiT $ do
    let
      s = unSections sections
    mkMenu s
    divClass "container-fluid p-2" $
      mkMain s (tellRedirectLocally [Page "events"])
