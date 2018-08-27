{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DeriveAnyClass #-}
{-# LANGUAGE OverloadedStrings #-}

module Lib
    ( parseStocks
    ) where

import Data.List
import GHC.Generics
import Data.Aeson
import Data.Scientific
import Control.Lens
import Network.Wreq

parseTicker :: String -> String
parseTicker = takeWhile (\x -> x /= ',') 

data Price = Price {
  price :: Scientific,
  time :: Int
} deriving (Generic, Show, ToJSON, FromJSON)

doublePrice :: Price -> Double
doublePrice  x = toRealFloat (price x)

data APIResponse = APIResponse {
  open :: Price,
  close :: Price,
  high :: Scientific,
  low :: Scientific
} deriving (Generic, Show, ToJSON, FromJSON)

generateURL :: String -> String
generateURL x = "https://api.iextrading.com/1.0/stock/"++x++"/ohlc"

delta a = (doublePrice (close a)) - (doublePrice (open a))

deltaPercent :: APIResponse -> Double
deltaPercent a = 100.0 * (delta a) / (doublePrice (open a))

generateMsgStr ::String -> APIResponse -> String
generateMsgStr sym x = sym ++ " " ++ (show (deltaPercent x))

getStockPrice :: String -> IO()
getStockPrice sym = do
  r <- asJSON =<< get (generateURL sym)
  let resp = (r ^. responseBody) 
  let msg = generateMsgStr sym resp
  putStrLn msg

getTickers = map parseTicker . lines 

parseStocks :: String -> [IO()]
parseStocks = map getStockPrice . getTickers
