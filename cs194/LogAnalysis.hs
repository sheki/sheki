{-# OPTIONS_GHC -Wall #-}
module LogAnalysis where
import Log

parseBody :: [String] -> MessageType -> LogMessage
parseBody (x:xs) mType = LogMessage mType (read x) (unwords xs)
parseBody _ _ = undefined

parseBoom :: String -> [String] -> LogMessage
parseBoom "I" arr = parseBody arr Info
parseBoom "W" arr = parseBody arr Warning
parseBoom "E" (x: arr) = parseBody arr (Error (read x))
parseBoom _ _ = undefined

parseMessage :: String -> LogMessage
parseMessage m = case words(m) of 
  (x:xs) -> parseBoom x xs
  _ -> Unknown m

myMap :: (a->b) -> [a] -> [b]
myMap f (x:xs) = (f x) : (map f xs)
myMap _ [] = []

myFilter :: (a->Bool) -> [a] -> [a]
myFilter f (x:xs)
  | (f x) = x : (myFilter f xs)
  | otherwise =  (myFilter f xs)
myFilter _ [] = []
 
myReduce :: (a->b->b) -> [a] ->b -> b
myReduce f (x:xs) v = (myReduce f xs (f x v))
myReduce _ [] v = v

parse :: String -> [LogMessage]
parse m = myMap parseMessage (lines m)

insert :: LogMessage -> MessageTree -> MessageTree
insert (Unknown _) root = root
insert m@(LogMessage _ _ _) Leaf = Node Leaf m Leaf
insert m@(LogMessage _ ts _) (Node l rm@(LogMessage _ rootTs _)  r) 
  | rootTs > ts = Node (insert m l) rm r
  | otherwise = Node l rm (insert m r)
insert _ _ = undefined

build :: [LogMessage] -> MessageTree
build arr = myReduce insert arr Leaf

inOrder :: MessageTree -> [LogMessage]
inOrder Leaf = []
inOrder (Node l m r) = (inOrder l) ++  [m] ++ (inOrder r)

filterFunc :: LogMessage -> Bool
filterFunc m = case m of
  (LogMessage (Error sev) _ _) -> sev >= 50
  _ -> False

extrMsg :: LogMessage -> String
extrMsg m = case m of
  (LogMessage _ _ msg) -> msg
  _ -> undefined

whatWentWrong :: [LogMessage] -> [String]
whatWentWrong msgs = (myMap extrMsg (myFilter filterFunc (inOrder (build msgs))))

