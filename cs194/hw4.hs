import Data.List

fun1 :: [Integer] -> Integer
fun1 [] = 1
fun1 (x:xs) 
  | even x = (x - 2) * fun1 xs
  | otherwise = fun1 xs

fun1' :: [Integer] -> Integer
fun1' = product . map (\x -> x -2). filter even

fun2 :: Integer -> Integer
fun2 1 = 0
fun2 n | even n = n + fun2 (n `div` 2)
  | otherwise = fun2 (3 * n + 1)

fun2' :: Integer -> Integer
fun2'  = sum . filter even . takeWhile (> 1) . iterate (\x-> if even x then x `div` 2 else 3 * x + 1)

data Tree a = Leaf
  | Node Integer (Tree a) a (Tree a)
  deriving (Show, Eq)

treeLevel :: Tree a -> Integer
treeLevel Leaf           = 0
treeLevel (Node n _ _ _) = n

insertTree :: a -> Tree a -> Tree a
insertTree input Leaf = Node 0 Leaf input Leaf
insertTree input (Node lev right val left) = let
  newRight = insertTree input right
  newLeft = insertTree input left
  rightLev = treeLevel right
  leftLev = treeLevel left in if rightLev > leftLev 
    then (Node (treeLevel newLeft + 1) newLeft val right) 
    else (Node (treeLevel newRight + 1) left val newRight)

foldTree :: [a] -> Tree a
foldTree ls = foldr insertTree Leaf ls


xor :: [Bool] -> Bool
xor = odd . foldl (\acc x -> if x then acc+1 else acc) 0 

map' :: (a -> b) -> [a] -> [b]
map' fn = foldl (\acc x -> acc ++ [fn x]) [] 

cartProd :: [a] -> [b] -> [(a, b)]
cartProd xs ys = [(x,y) | x <- xs, y <- ys]
sieveSundaram :: Integer -> [Integer]
sieveSundaram n = let
  removal = map (\(i, j) -> i + j + 2*i*j)  (filter (\(i, j) -> i <= j) (cartProd [1..n] [1..n]))
  rest = [1..n] \\ removal 
  in map (\x -> (2*x) + 1) rest

myRev :: [a] -> [a]
myRev = foldr (\xs acc ->  acc ++ [xs]) []

myFoldl :: (a -> b -> a) -> a -> [b] -> a
myFoldl f base x = (foldr (\x y -> (f y x)) base  (myRev x))
--
--
