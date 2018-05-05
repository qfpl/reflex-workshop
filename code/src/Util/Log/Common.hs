{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE OverloadedStrings #-}
module Util.Log.Common (
    API
  ) where

import Servant.API

type API =
       "fetch"                                :> Get '[JSON] (Int, Int)
  :<|> "update" :> ReqBody '[JSON] (Int, Int) :> Post '[JSON] (Int, Int)


