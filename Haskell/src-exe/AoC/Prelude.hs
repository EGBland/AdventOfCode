module AoC.Prelude (
    Problem(..), dummy,
    solveProblem
) where

import System.TimeIt ( timeItT )
import Text.Printf ( printf )

data Problem = Problem Int Int (String -> String) (String -> String)

solveProblem :: Problem -> IO ((Double,String),(Double,String))
solveProblem (Problem year day d1 d2) = do
    input <- readFile $ printf "inputs/%d/day%d.txt" year day
    r1 <- timeItT $ return $! d1 input
    r2 <- timeItT $ return $! d2 input
    return (r1,r2)

dummy :: String -> String
dummy _ = "0"