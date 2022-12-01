module AoC.Year2015.Day3 ( day3 ) where

import AoC.Prelude ( Problem(..) )
import Data.List ( nub )

nextVisit :: (Int,Int) -> Char -> (Int,Int)
nextVisit (x,y) c = case c of
    '^' -> (x,y+1)
    '>' -> (x+1,y)
    'v' -> (x,y-1)
    '<' -> (x-1,y)
    _   -> (x,y)

visits :: String -> [(Int,Int)]
visits = scanl nextVisit (0,0)

solveProblem1 :: String -> Int
solveProblem1 = length . nub . visits

solveProblem2 :: String -> Int
solveProblem2 _ = 0

day3 :: Problem
day3 = Problem 2015 3 solveProblem1 solveProblem2