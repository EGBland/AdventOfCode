module AoC.Year2022.Day4 ( day4 ) where

import AoC.Prelude ( Problem(..) )

day4 :: Problem
day4 = Problem 2022 4 solveProblem1 solveProblem2

solveProblem1 :: String -> String
solveProblem1 = show . length . filter (uncurry completelyRedundant) . map readInterval . lines

solveProblem2 :: String -> String
solveProblem2 = show . length . filter (uncurry partlyRedundant) . map readInterval . lines

readInterval :: String -> ((Int,Int),(Int,Int))
readInterval str =
    let
        n1_1 = takeWhile (/='-') str
        n1_2 = takeWhile (/=',') . drop (length n1_1 + 1) $ str
        n2_1 = takeWhile (/='-') . drop (length n1_1 + length n1_2 + 2) $ str
        n2_2 = drop (length n1_1 + length n1_2 + length n2_1 + 3) str
    in
        ((read n1_1, read n1_2),(read n2_1, read n2_2))

completelyRedundant :: (Int,Int) -> (Int,Int) -> Bool
completelyRedundant (a,b) (c,d) = (c >= a && d <= b) || (a >= c && b <= d)

partlyRedundant :: (Int,Int) -> (Int,Int) -> Bool
partlyRedundant (a,b) (c,d) = (a <= d && b >= c) || (d <= a && c >= b)