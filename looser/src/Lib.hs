{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DeriveAnyClass #-}
{-# LANGUAGE OverloadedStrings #-}

module Lib
  ( parseStocks
  )
where

import           Data.List
import           GHC.Generics
import           Data.Aeson
import           Data.Scientific
import           Control.Lens
import           Network.Wreq

parseTicker :: String -> String
parseTicker = takeWhile (\x -> x /= ',')

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

generateURL :: String -> String
generateURL x = "https://api.iextrading.com/1.0/stock/" ++ x ++ "/ohlc"

delta a = (doublePrice (close a)) - (doublePrice (open a))

deltaPercent :: APIResponse -> Double
deltaPercent a = 100.0 * (delta a) / (doublePrice (open a))

generateMsgStr :: String -> APIResponse -> String
generateMsgStr sym x = sym ++ " " ++ (show (deltaPercent x))

getStockPrice :: String -> IO (String, APIResponse)
getStockPrice sym = do
  r <- asJSON =<< get (generateURL sym)
  let resp = (r ^. responseBody)
  return (sym, resp)

getTickers = map parseTicker . lines

sortByDifference :: [(String, APIResponse)] -> [(String, APIResponse)]
sortByDifference =
  sortBy (\(_, x) (_, y) -> compare (deltaPercent x) (deltaPercent y))

sorter = fmap sortByDifference

genMsg = intercalate "\n" . map (\(x, y) -> generateMsgStr x y) . take 5

withHeader :: String -> [(String, APIResponse)] -> String
withHeader x y = x ++ "\n" ++ (genMsg y)

finalMessage x =
  (withHeader "==Gainers==" x) ++ (withHeader "==Loosers==" (reverse x))

driver = sorter . mapM getStockPrice . getTickers

parseStocks :: String -> IO String
parseStocks = fmap finalMessage . driver
