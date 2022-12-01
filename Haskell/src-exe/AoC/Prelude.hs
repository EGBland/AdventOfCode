module AoC.Prelude (
    Problem(..),
    solveProblem
) where

import Text.Printf ( printf )

data Problem = Problem Int Int (String -> Int) (String -> Int)

solveProblem :: Problem -> IO (Int,Int)
solveProblem (Problem year day d1 d2) = do
    input <- readFile $ printf "inputs/%d/day%d.txt" year day
    return (d1 input, d2 input)