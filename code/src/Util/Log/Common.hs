{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric #-}
module Util.Log.Common (
    API
  ) where

import Servant.API

import Util.WorkshopState

type API =
       "fetch"                                :> Get '[JSON] WorkshopState
  :<|> "update" :> ReqBody '[JSON] WorkshopState :> Post '[JSON] WorkshopState


