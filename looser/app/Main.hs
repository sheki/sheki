module Main where

import           Lib
import           Control.Concurrent.ParallelIO.Global


main :: IO ()
main = do
  contents <- readFile "stocks.txt"
  output   <- (parseStocks contents)
  putStr output
  stopGlobalPool
