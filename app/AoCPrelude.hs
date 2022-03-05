module AoCPrelude (
    Problem (..),
    doProblem1, doProblem2
)
where

data Problem = Problem (String -> Int) (String -> Int)

doProblem1 :: Problem -> String -> Int
doProblem1 (Problem p1 _) = p1

doProblem2 :: Problem -> String -> Int
doProblem2 (Problem _  p2) = p2