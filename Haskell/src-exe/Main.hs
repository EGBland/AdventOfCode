module Main where

import AoC.Prelude
import AoC.Year2022.Day1
import Data.List (sort)
import Data.List.Split (splitOn)

main :: IO ()
main = solveProblem day1 >>= print