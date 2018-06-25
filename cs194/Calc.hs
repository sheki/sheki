{-# LANGUAGE TypeSynonymInstances #-}
{-# LANGUAGE FlexibleInstances #-}


import ExprT
import Parser
import qualified StackVM

eval :: ExprT -> Integer
eval (Lit i) = i
eval (Add r l) = (eval l) + (eval r) 
eval (Mul r l) = (eval l) * (eval r) 

class Expr a where
  lit  :: Integer -> a
  add  :: a -> a -> a
  mul  :: a -> a -> a

instance Expr ExprT where
  lit i = (Lit i)
  add r l = (Add r l)
  mul r l = (Mul r l)

evalStr :: String -> Maybe Integer
evalStr input = let 
  res = parseExp Lit Add Mul input
  in case res of Nothing -> Nothing
                 Just expr -> Just (eval expr)

instance Expr Integer where
  lit = id
  add r l = r + l
  mul r l = r * l

instance Expr Bool where
  lit i =  i > 0
  add r l = r || l
  mul r l = r && l

instance Expr MinMax where
  lit i = MinMax i
  add r l = (max r l)
  mul r l = (min r l)

reify :: ExprT -> ExprT
reify = id

newtype MinMax = MinMax Integer deriving (Eq, Show, Ord)
newtype Mod7 = Mod7 Integer deriving (Eq, Show)
instance Expr StackVM.Program where
  lit x = [StackVM.PushI x]
  -- x and y are Programs that need to run. The result of running x and y will
  -- be the top two things in the stack.
  add x y = x ++ y ++ [StackVM.Add]
  mul x y = x ++ y ++ [StackVM.Mul]

-- Tests:
--
-- (mul (add (lit 3) (lit 5)) (lit 5)) :: StackVM.Program
--
-- StackVM.stackVM (mul (add (lit 3) (lit 5)) (lit 5))

compile :: String -> Maybe StackVM.Program
compile s = (parseExp lit add mul s) :: Maybe StackVM.Program

-- Tests:
--
-- compile "(3 * 4) + 9"

run :: String -> Either String StackVM.StackVal
run s = case compile s of
          Nothing -> Left "nothing"
          Just p  -> StackVM.stackVM p
