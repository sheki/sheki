import Data.List
takeN :: [a] -> Int -> [a] 
takeN (x:xs) n = x : (takeN (drop (n-1) xs) n) 
takeN [] _ = []


skips :: [a] -> [[a]]
skips l = let 
  skipHelp n = takeN (drop (n - 1) l) n
  in map skipHelp [1..(length l)]

localMaxima :: [Integer] -> [Integer] 
localMaxima [] = []
localMaxima l@(a:b:c:xs) 
  | a<b && b > c = [b] ++ (localMaxima (drop 1 l))
localMaxima l = (localMaxima (drop 1 l))

histogram :: [Integer] -> String
histogram arr = let
  cntArr = map (\n -> length (filter (\x -> x == n) arr)) [1..9]
  maxSize = maximum cntArr
  row n = map (\x -> if x >= n then '*' else ' ')  cntArr 
  in (intercalate "\n" (map row (reverse [1..maxSize]))) ++ "\n==========\n0123456789\n"

