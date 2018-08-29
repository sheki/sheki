module Main where

import           Lib

main :: IO ()
main = do
  contents <- readFile "stocks.txt"
  output   <- (parseStocks contents)
  putStr output
