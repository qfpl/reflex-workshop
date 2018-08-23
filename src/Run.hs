module Run (run) where

import Data.Maybe (fromMaybe)
import System.Environment (lookupEnv)

import Util.Bootstrap
import UI
import Workshop

run :: IO ()
run = do
  mAssets <- lookupEnv "WORKSHOP_ASSETS"
  let assets = fromMaybe "./assets" mAssets
  debugApp 8080 assets $ ui workshop

