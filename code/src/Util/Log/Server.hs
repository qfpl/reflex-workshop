{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE FlexibleContexts #-}
module Util.Log.Server (
    serverApp
  , serverAppOr
  ) where

import Control.Monad (void, unless)
import Control.Concurrent (forkIO)
import Data.Proxy (Proxy(..))

import System.Directory (doesFileExist)

import Control.Monad.Trans (liftIO)

import Servant.API

import Network.Wai (Application)

import Control.Monad.STM (atomically)

import qualified Data.Map as Map

import Reflex
import Reflex.Host.Basic
import Reflex.Server.Servant
import Util.Ticket
import Reflex.Server.Wai

import Util.WorkshopState
import Util.Log.Common

serverApp :: (Application -> IO ()) -> IO ()
serverApp run = do
  td <- newTicketDispenser
  let mkT = atomically $ getNextTicket td
  basicHostForever $ do
    sApp <- serverGuest (Proxy :: Proxy API) mkT serverNetwork
    void . liftIO . forkIO $ run sApp

serverAppOr :: Application -> (Application -> IO ())-> IO ()
serverAppOr app run = do
  td <- newTicketDispenser
  let mkT = atomically $ getNextTicket td
  basicHostForever $ do
    sApp <- serverGuest (Proxy :: Proxy (API :<|> Raw)) mkT $ serverNetworkOr app
    void . liftIO . forkIO $ run sApp

positionFile :: FilePath
positionFile = "position.txt"

setupFile :: IO ()
setupFile = do
  exists <- doesFileExist positionFile
  unless exists $
    writeFile positionFile . show $ initialWorkshopState

serverNetwork :: (Ord tag, Reflex t, BasicGuestConstraints t m)
              => EventsIn' t tag () API
              -> BasicGuest t m (EventsOut t tag API)
serverNetwork (eFetchIn :<|> eUpdateIn) = do
  ePostBuild <- getPostBuild
  performEvent_ $ liftIO setupFile <$ ePostBuild
  let
    fetch (t, _) =
      fmap (\x -> Map.singleton t (Right . read $ x)) . readFile $ positionFile
    update (t, u)=
      fmap (\_ -> Map.singleton t (Right u)) . writeFile positionFile . show $ u
  eFetchOut <- performEvent $ liftIO . fetch <$> eFetchIn
  eUpdateOut <- performEvent $ liftIO . update <$> eUpdateIn

  pure $ eFetchOut :<|> eUpdateOut

serverNetworkOr :: (Ord tag, Reflex t, BasicGuestConstraints t m)
                => Application
                -> EventsIn' t tag () (API :<|> Raw)
                -> BasicGuest t m (EventsOut t tag (API :<|> Raw))
serverNetworkOr app (eIn :<|> eRawIn) = do
  eOut <- serverNetwork eIn
  eRawOut <- liftWaiApplicationTagged app $ (\(x, _, y) -> (x, y)) <$> eRawIn
  pure $ eOut :<|> eRawOut
