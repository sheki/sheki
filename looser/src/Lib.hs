{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DeriveAnyClass #-}
{-# LANGUAGE OverloadedStrings #-}

module Lib
  ( parseStocks
  )
where

import           Data.List
import           Data.List.Split
import           GHC.Generics
import           Data.Aeson
import           Data.Scientific
import           Control.Lens
import           Network.Wreq
import           Text.Printf
import           Control.Concurrent.ParallelIO.Global

data Price = Price {
  price :: Scientific,
  time :: Int
} deriving (Generic, Show, ToJSON, FromJSON)

doublePrice :: Price -> Double
doublePrice x = toRealFloat (price x)

data APIResponse = APIResponse {
  open :: Price,
  close :: Price,
  high :: Scientific,
  low :: Scientific
} deriving (Generic, Show, ToJSON, FromJSON)

data Stock = Stock {
  ticker :: String,
  name :: String,
  industry :: String
}

generateURL :: String -> String
generateURL x = "https://api.iextrading.com/1.0/stock/" ++ x ++ "/ohlc"

delta a = (doublePrice (close a)) - (doublePrice (open a))

deltaPercent :: APIResponse -> Double
deltaPercent a = 100.0 * (delta a) / (doublePrice (open a))

generateMsgStr :: Stock -> APIResponse -> String
generateMsgStr sym x =
  printf "%s %.2f %s %s" (ticker sym) (deltaPercent x) (name sym) (industry sym)

getStockPrice :: Stock -> IO (Stock, APIResponse)
getStockPrice s = do
  r <- asJSON =<< get (generateURL (ticker s))
  let resp = (r ^. responseBody)
  return (s, resp)

buildStock :: [String] -> Stock
buildStock (x : y : z : xs) = Stock x y z
buildStock (x     : y : []) = Stock x y ""
buildStock (x         : []) = Stock x "" ""
buildStock _                = Stock "" "" ""

parseTicker = buildStock . splitOn ","

getTickers = map parseTicker . lines

sortByDifference :: [(a, APIResponse)] -> [(a, APIResponse)]
sortByDifference =
  sortBy (\(_, x) (_, y) -> compare (deltaPercent x) (deltaPercent y))

sorter = fmap sortByDifference

genMsg = intercalate "\n" . map (\(x, y) -> generateMsgStr x y) . take 10

withHeader :: String -> [(Stock, APIResponse)] -> String
withHeader x y = x ++ "\n" ++ (genMsg y)

finalMessage x =
  (withHeader "==📈📈📈📈📈📈📈=="  x)
    ++ "\n"
    ++ (withHeader "==📉📉📉📉📉📉📉==" (reverse x))
    ++ "\n"

driver = sorter . parallel . map getStockPrice . getTickers

parseStocks :: String -> IO String
parseStocks = fmap finalMessage . driver
