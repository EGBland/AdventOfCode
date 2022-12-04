module AoC.Year2019.Day1 ( day1 ) where

import AoC.Prelude ( Problem(..), dummy )

day1 :: Problem
day1 = Problem 2019 1 solveProblem1 solveProblem2

solveProblem1 :: String -> Int
solveProblem1 = sum . map (moduleCost . read) . lines

solveProblem2 :: String -> Int
solveProblem2 input =
    let
        cost = sum . map (moduleCost . read) . lines $ input
        costIter = iterate moduleCost cost
    in
        sum . takeWhile (>=0) . iterate moduleCost $ cost

moduleCost :: Int -> Int
moduleCost x = x `div` 3 - 2