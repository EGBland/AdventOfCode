module AoC.Year2015.Day3 ( day3 ) where

import AoC.Prelude ( Problem(..) )
import Data.List ( nub )

day3 :: Problem
day3 = Problem 2015 3 solveProblem1 solveProblem2

solveProblem1 :: String -> Int
solveProblem1 = length . nub . visits

solveProblem2 :: String -> Int
solveProblem2 input =
    let
        (santaPath, roboPath) = divvy input
        santaVisits = visits santaPath
        roboVisits = visits roboPath
    in
        length . nub $ santaVisits ++ roboVisits

nextVisit :: (Int,Int) -> Char -> (Int,Int)
nextVisit (x,y) c = case c of
    '^' -> (x,y+1)
    '>' -> (x+1,y)
    'v' -> (x,y-1)
    '<' -> (x-1,y)
    _   -> (x,y)

visits :: String -> [(Int,Int)]
visits = scanl nextVisit (0,0)

divvy' :: a -> ([a],[a]) -> ([a],[a])
divvy' x (l1,l2) = (x:l2,l1)

divvy :: [a] -> ([a],[a])
divvy = foldr divvy' ([],[])