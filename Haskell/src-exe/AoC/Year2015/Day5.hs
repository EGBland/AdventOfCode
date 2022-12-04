module AoC.Year2015.Day5 ( day5 ) where

import AoC.Prelude ( Problem(..), dummy )
import Data.List ( isInfixOf )
import Text.Printf ( printf )

day5 :: Problem
day5 = Problem 2015 5 solveProblem1 dummy

solveProblem1 :: String -> Int
solveProblem1 = length . filter isNice . lines

isNice :: String -> Bool
isNice s = all id [
        not . any id $ [isInfixOf "ab" s, isInfixOf "cd" s, isInfixOf "pq" s, isInfixOf "xy" s],
        (>=3) . length . filter isVowel $ s,
        any id $ [isInfixOf (printf "%s%s" [x] [x]) s | x <- ['a'..'z']]
    ]
    

isVowel :: Char -> Bool
isVowel = flip elem ['a','e','i','o','u']