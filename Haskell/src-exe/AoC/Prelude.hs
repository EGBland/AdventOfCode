module AoC.Prelude (
    Problem(..),
    solveProblem
) where

import Text.Printf ( printf )

data Problem = Problem Int (String -> Int) (String -> Int)

solveProblem :: Problem -> IO (Int,Int)
solveProblem (Problem day d1 d2) = do
    input <- readFile $ printf "inputs/day%d.txt" day
    return (d1 input, d2 input)