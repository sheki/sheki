module Lib
    ( parseStocks
    ) where

import Data.List

parseTicker :: String -> String
parseTicker = takeWhile (\x -> x /= ',') 

parseStocks :: String -> String
parseStocks x = intercalate "," (map parseTicker (lines x))
