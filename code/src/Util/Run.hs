{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
module Util.Run (
    run
  ) where

import           Data.Foldable (traverse_)
import           Data.Maybe (fromMaybe)
import           Data.Monoid ((<>))

import qualified Data.Text                              as Text
import qualified Data.Map                               as Map

import           System.FilePath                        ((</>))
import           System.Directory                       (listDirectory)

import           Control.Lens

import           Network.Wai.Handler.Warp               (defaultSettings,
                                                         runSettings, setPort,
                                                         setTimeout)
import           Network.WebSockets                     (ConnectionOptions, defaultConnectionOptions)

import           Language.Javascript.JSaddle            (JSM)
import           Language.Javascript.JSaddle.Run        (syncPoint)
import           Language.Javascript.JSaddle.Run.Files  (indexHtml)

import           Language.Javascript.JSaddle.WebSockets (debugWrapper, jsaddleOr, jsaddleJs)
import qualified Network.Wai                            as W

import Network.Wai.Application.Static

import Data.ByteString.Lazy                             (ByteString)
import qualified Network.HTTP.Types                     as H (status200)

import Reflex.Dom.Core

import Util.Log.Server

bootstrapHead :: MonadWidget t m => m ()
bootstrapHead = do
  let
    stylesheet s =
      elAttr "link" (Map.fromList [("rel", "stylesheet"), ("href", s)]) $ pure ()
  elAttr "meta" ("charset" =: "utf-8") $ pure ()
  elAttr "meta" ("name" =: "viewport" <>
                 "content" =: "width=device-width, initial-scale=1, shrink-to-fit=no") $ pure ()

  stylesheet "css/bootstrap.min.css"
  stylesheet "css/font-awesome.min.css"
  stylesheet "css/syntax.css"
  stylesheet "css/style.css"
  stylesheet "css/todo.css"

bootstrapTail :: MonadWidget t m => m ()
bootstrapTail =
  let
    script src =
      elAttr "script" ("src" =: src) $ pure ()
  in do
    script "js/jquery-3.2.1.slim.min.js"
    script "js/popper.min.js"
    script "js/bootstrap.min.js"

serveWithCss :: (forall x. Widget x ()) -> IO (W.Application, JSM ())
serveWithCss w = do
  let
    frontend =
      mainWidgetWithHead
        bootstrapHead
        (w >> bootstrapTail)
  let
    backend = staticApp $ defaultWebAppSettings "./assets"
  pure (backend, frontend)

jsaddleWithAppOr :: ConnectionOptions -> JSM () -> W.Application -> IO W.Application
jsaddleWithAppOr opts entryPoint otherApp = jsaddleOr opts entryPoint $ \req sendResponse ->
  (fromMaybe (otherApp req sendResponse)
  (jsaddleAppPartialWithJs (jsaddleJs True) req sendResponse))

jsaddleAppPartialWithJs :: ByteString -> W.Request -> (W.Response -> IO W.ResponseReceived) -> Maybe (IO W.ResponseReceived)
jsaddleAppPartialWithJs js req sendResponse =
  case (W.requestMethod req, W.pathInfo req) of
    ("GET", []) -> Just $ sendResponse $ W.responseLBS H.status200 [("Content-Type", "text/html")] indexHtml
    ("GET", ["jsaddle.js"]) -> Just $ sendResponse $ W.responseLBS H.status200 [("Content-Type", "application/javascript")] js
    _ -> Nothing

-- | A @main@ for doing development.
devMain :: W.Application -> JSM () -> Int -> IO ()
devMain backend frontend port = do
  app <- jsaddleWithAppOr
    defaultConnectionOptions
    (frontend >> syncPoint)
    backend

  runSettings (defaultSettings & setTimeout 3600 & setPort port) app

-- | A version of @devMain@ that can be used with @ghcid --test@ to get an auto-reloading server.
devMainAutoReload :: W.Application -> JSM () -> Int -> IO ()
devMainAutoReload backend frontend port =
  debugWrapper $ \refreshMiddleware registerContext ->
    devMain (refreshMiddleware backend) (registerContext >> frontend) port

run :: Int ->(forall x. Widget x ()) -> IO ()
run port w = do
  (backend, frontend) <- serveWithCss w
  serverAppOr backend $ \a ->
    devMainAutoReload a frontend port
