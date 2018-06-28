{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE CPP #-}
{-# LANGUAGE UndecidableInstances #-}
module UI.Base (
    UiT
  , runUiT
  ) where

import Data.Coerce (coerce)

import Control.Monad.Trans (MonadTrans(..), MonadIO(..))
import Control.Monad.Fix (MonadFix)
import Control.Monad.Exception (MonadException, MonadAsyncException)
import Control.Monad.Ref (MonadRef(..), MonadAtomicRef(..))
import Control.Monad.Reader (MonadReader(..), ReaderT, runReaderT)
import Control.Monad.State (MonadState(..))

import Reflex
import Reflex.Host.Class
import Reflex.Dom.Core

import Reflex.Dom.Routing.Nested
import Reflex.Dom.Routing.Writer
import Reflex.Dom.Storage.Base
import Reflex.Dom.Storage.Class

import GHCJS.DOM.Types (MonadJSM)

import State
import Types.Interactivity
import Types.RouteFragment

newtype UiT t m a = UiT {
  unUiT :: RouteWriterT t RouteFragment (RouteT t RouteFragment (StorageT t AppTags (ReaderT Interactivity m))) a
  } deriving (Functor, Applicative, Monad, MonadIO, MonadFix, MonadHold t,
              MonadException, MonadAsyncException,
              MonadSample t, PostBuild t, MonadReflexCreateTrigger t, TriggerEvent t, MonadAtomicRef)

instance MonadTrans (UiT t) where
  lift = UiT . lift . lift . lift . lift

instance Requester t m => Requester t (UiT t m) where
  type Request (UiT t m) = Request m
  type Response (UiT t m) = Response m
  requesting = lift . requesting
  requesting_ = lift . requesting_

instance (Adjustable t m, MonadHold t m) => Adjustable t (UiT t m) where
  runWithReplace a0 a' = UiT $ runWithReplace (unUiT a0) (fmapCheap unUiT a')
  traverseDMapWithKeyWithAdjust f dm edm = UiT $ traverseDMapWithKeyWithAdjust (\k v -> unUiT $ f k v) (coerce dm) (coerceEvent edm)
  {-# INLINABLE traverseDMapWithKeyWithAdjust #-}
  traverseIntMapWithKeyWithAdjust f dm edm = UiT $ traverseIntMapWithKeyWithAdjust (\k v -> unUiT $ f k v) (coerce dm) (coerceEvent edm)
  {-# INLINABLE traverseIntMapWithKeyWithAdjust #-}
  traverseDMapWithKeyWithAdjustWithMove f dm edm = UiT $ traverseDMapWithKeyWithAdjustWithMove (\k v -> unUiT $ f k v) (coerce dm) (coerceEvent edm)
  {-# INLINABLE traverseDMapWithKeyWithAdjustWithMove #-}

instance PerformEvent t m => PerformEvent t (UiT t m) where
  type Performable (UiT t m) = Performable m
  performEvent_ = lift . performEvent_
  performEvent = lift . performEvent

instance MonadRef m => MonadRef (UiT t m) where
  type Ref (UiT t m) = Ref m
  newRef = lift . newRef
  readRef = lift . readRef
  writeRef r = lift . writeRef r

instance (MonadQuery t q m, Monad m) => MonadQuery t q (UiT t m) where
  tellQueryIncremental = lift . tellQueryIncremental
  askQueryResult = lift askQueryResult
  queryIncremental = lift . queryIncremental

instance (Monad m, NotReady t m) => NotReady t (UiT t m)

instance (DomBuilder t m, MonadHold t m, MonadFix m) => DomBuilder t (UiT t m) where
  type DomBuilderSpace (UiT t m) = DomBuilderSpace m
  textNode = lift . textNode
  element elementTag cfg (UiT child) = UiT $ element elementTag cfg child
  inputElement = lift . inputElement
  textAreaElement = lift . textAreaElement
  selectElement cfg (UiT child) = UiT $ selectElement cfg child
  placeRawElement = lift . placeRawElement
  wrapRawElement e = lift . wrapRawElement e

instance HasDocument m => HasDocument (UiT t m)

instance HasJSContext m => HasJSContext (UiT t m) where
  type JSContextPhantom (UiT t m) = JSContextPhantom m
  askJSContext = UiT askJSContext
#ifndef ghcjs_HOST_OS
instance MonadJSM m => MonadJSM (UiT t m)
#endif

instance MonadState s m => MonadState s (UiT t m) where
  get = lift get
  put = lift . put

instance Monad m => MonadReader Interactivity (UiT t m) where
  ask = UiT . lift . lift . lift $ ask
  local f = UiT . local f . unUiT
  reader = UiT . lift . reader

instance (Reflex t, Monad m) => HasStorage t AppTags (UiT t m) where
  askStorage = UiT . lift . lift $ askStorage
  tellStorage = UiT . lift . lift . tellStorage

instance MonadWidget t m => HasRoute t RouteFragment (UiT t m) where
  routeContext = UiT . lift $ routeContext
  withSegments f = UiT . withSegments f . unUiT

instance MonadWidget t m => RouteWriter t RouteFragment (UiT t m) where
  tellRoute = UiT . tellRoute

runUiT :: MonadWidget t m
       => UiT t m ()
       -> m ()
runUiT uit = do
  i <- liftIO getInteractivity
  flip runReaderT i .
    runStorageT LocalStorage .
    runRoute toSegments fromSegments .
    fmap snd .
    runRouteWriterT .
    unUiT $
    uit
