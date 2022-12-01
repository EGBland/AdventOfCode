module AoC.Year2015.Day1 (day1) where

import AoC.Prelude ( Problem(..) )
import Data.List (partition)

solveProblem1 :: String -> Int
solveProblem1 = (\(xs,ys) -> length xs - length ys) . partition (=='(')

solveProblem2 :: String -> Int
solveProblem2 = length . takeWhile (>=0) . scanl (\acc x -> if x == '(' then acc + 1 else acc - 1) 0

day1 :: Problem
day1 = Problem 2015 1 solveProblem1 solveProblem2