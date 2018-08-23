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

import Reflex.Dom.Core

import Reflex.Dom.Routing.Writer

import Types.RouteFragment
import Types.Section
import UI.Base
import UI.Menu
import UI.Routing

ui :: forall t m.
      MonadWidget t m
   => Sections
   -> m ()
ui (Sections s) =
  runUiT $ divClass "container-fluid" $ do
    mkMenu s
    mkMain s (tellRedirectLocally [Page "events"])
