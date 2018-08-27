#!/usr/bin/env stack
-- stack --install-ghc runghc

apply_n f n x =	 if n==0 then x
else apply_n f (n-1) (f x)
plus a b = apply_n ((+) 1) b a
mult a b = apply_n ((+) a) b 0
expon a b = apply_n ((*) a) b 1


