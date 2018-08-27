module Main where

import Lib

runall :: [IO ()] -> IO ()
runall [] = return ()
runall (firstelem:remainingelems) =
    do firstelem
       runall remainingelems

main :: IO ()
main = do 
  contents <- readFile "stocks.txt"
  runall (parseStocks contents)
