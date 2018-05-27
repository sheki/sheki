takeN :: [a] -> Int -> [a] 
takeN (x:xs) n = x : (takeN (drop (n-1) xs) n) 
takeN [] _ = []


skips :: [a] -> [[a]]
skips l = let 
  skipHelp n = takeN (drop (n - 1) l) n
  in map skipHelp [1..(length l)]
