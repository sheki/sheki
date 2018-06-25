fib :: Integer -> Integer 
fib 0 = 1
fib 1 = 1
fib n = (fib (n - 1)) + (fib (n-2))

fibs1 :: [Integer] 
fibs1 = map fib [0..]

fibs2 :: [Integer]
fibs2 = 0 : 1 : zipWith (+) fibs2 (tail fibs2)

data Stream a = Stream a (Stream a)

streamToList :: Stream a -> [a]
streamToList (Stream value rest) = value : streamToList rest

instance Show a => Show (Stream a) where
    show = show . take 100 . streamToList

streamRepeat :: a -> Stream a
streamRepeat val = Stream val (streamRepeat val)

streamMap :: (a -> b) -> Stream a -> Stream b
streamMap fn (Stream value rest) = Stream (fn value) (streamMap fn rest)

streamFromSeed :: (a -> a) -> a -> Stream a
streamFromSeed fn initial = Stream initial (streamFromSeed fn (fn initial))

nats :: Stream Integer
nats = streamFromSeed (\x -> x + 1) 0
