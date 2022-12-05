module AoC.Year2022.Day3 ( day3 ) where

import AoC.Prelude ( Problem(..) )
import Data.Char ( ord )
import Data.List ( intersect )
import Data.List.Split ( chunksOf )

day3 :: Problem
day3 = Problem 2022 3 solveProblem1 solveProblem2

solveProblem1 :: String -> String
solveProblem1 = show . sum . map (priority . head . uncurry intersect . halve) . lines

solveProblem2 :: String -> String
solveProblem2 = show . sum . map (priority . head . foldr1 intersect) . chunksOf 3 . lines

priority :: Char -> Int
priority c = ord c - (if elem c ['A'..'Z'] then 38 else 96)

halve :: [a] -> ([a],[a])
halve xs = (take n xs, drop n xs) where n = length xs `div` 2