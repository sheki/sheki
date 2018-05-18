toDigitsRev :: Integer -> [Integer]
toDigitsRev 0 = []
toDigitsRev n =  n `mod` 10 : toDigitsRev(n `div` 10) 

revList :: [Integer] -> [Integer]
revList [] = []
revList (x:xs) = (revList xs) ++ [x]

toDigits :: Integer -> [Integer]
toDigits n  = revList(toDigitsRev n)

-- doubleHelper:: [Integer] -> Bool -> [Integer]
-- doubleHelper []  _ = []
-- doubleHelper (x:xs) True = 2*x : doubleHelper(xs, False)
-- doubleHelper (x:xs) False = x : doubleHelper(xs, True)
--
doubleLeft :: [Integer] -> [Integer]
doubleLeft [] = []
doubleLeft [x] = [x]
doubleLeft (x:y:xs) = x: 2*y : doubleLeft(xs)

doubleEveryOther :: [Integer] -> [Integer]
doubleEveryOther l = revList ( doubleLeft (revList l))

sumDigits :: [Integer] -> Integer
sumDigits [] = 0
sumDigits (x:xs) = (mod x 10) + (div x 10) + (sumDigits xs)

validate :: Integer -> Bool
validate n = (mod (sumDigits (doubleEveryOther (toDigits n))) 10) == 0

type Peg = String
type Move = (Peg, Peg)
hanoi :: Integer -> Peg -> Peg -> Peg -> [Move]
hanoi 0 _ _ _  = []
hanoi 1 a b c = [(a,b)]
hanoi n a b c = (hanoi (n-1) a c b) ++ [(a,b)] ++ (hanoi (n-1) c b a)
