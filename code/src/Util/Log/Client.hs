{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ScopedTypeVariables #-}
module Util.Log.Client (
    fetch
  , update
  ) where

import Control.Monad (void)
import Data.Proxy (Proxy(..))

import Data.Text (Text)

import Servant.API
import Servant.Reflex

import Reflex
import Reflex.Dom.Core

import Util.Log.Common

fetch :: forall t m. MonadWidget t m => Event t () -> m (Event t Text, Event t (Int, Int))
fetch e =
  let
    fetch' :<|> _ = client (Proxy :: Proxy API) (Proxy :: Proxy m) (Proxy :: Proxy ()) (pure $ BasePath "/")
  in do
    r <- fetch' e
    pure (fmapMaybe reqFailure r, fmapMaybe reqSuccess r)


update :: forall t m. MonadWidget t m => Dynamic t (Int, Int) -> Event t () -> m (Event t Text, Event t (Int, Int))
update d e =
  let
    _ :<|> update' = client (Proxy :: Proxy API) (Proxy :: Proxy m) (Proxy :: Proxy ()) (pure $ BasePath "/")
  in do
    r <- update' (Right <$> d) e
    pure (fmapMaybe reqFailure r, fmapMaybe reqSuccess r)
