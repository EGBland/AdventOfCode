module AoC.Year2022.Day1 (day1) where

import AoC.Prelude ( Problem(..) )
import Data.List ( sort )
import Data.List.Split ( splitOn )

elfSums :: String -> [Int]
elfSums = map (sum . map read . lines) . splitOn "\n\n"

solveProblem1 :: String -> String
solveProblem1 = show . maximum . elfSums

solveProblem2 :: String -> String
solveProblem2 = show . sum . take 3 . reverse . sort . elfSums

day1 :: Problem
day1 = Problem 2022 1 solveProblem1 solveProblem2