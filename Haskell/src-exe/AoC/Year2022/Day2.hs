module AoC.Year2022.Day2 (day2) where

import AoC.Prelude ( Problem(..) )

data Move = Rock | Paper | Scissors
    deriving (Show, Eq)

data Result = Win | Draw | Loss
    deriving (Show, Eq)

day2 :: Problem
day2 = Problem 2022 2 solveProblem1 solveProblem2

solveProblem1 :: String -> Int
solveProblem1 = sum . map (score . getMove) . lines

solveProblem2 :: String -> Int
solveProblem2 = sum . map (score . (\(m,r) -> (m, infer (m,r))) . getResult) . lines

readMove :: Char -> Move
readMove c = case c of
    'A' -> Rock
    'B' -> Paper
    'C' -> Scissors
    'X' -> Rock
    'Y' -> Paper
    'Z' -> Scissors

readResult :: Char -> Result
readResult c = case c of
    'X' -> Loss
    'Y' -> Draw
    'Z' -> Win

getMove :: String -> (Move,Move)
getMove str = (readMove $ str!!0, readMove $ str!!2)

getResult :: String -> (Move,Result)
getResult str = (readMove $ str!!0, readResult $ str!!2)

infer :: (Move,Result) -> Move
infer (m,r) =
    case r of
        Win -> case m of
            Rock -> Paper
            Paper -> Scissors
            Scissors -> Rock
        Draw -> m
        Loss -> case m of
            Rock -> Scissors
            Paper -> Rock
            Scissors -> Paper

result :: (Move,Move) -> Result
result (m1,m2) = 
    case m2 of
        Rock -> case m1 of
            Rock -> Draw
            Paper -> Loss
            Scissors -> Win
        Paper -> case m1 of
            Rock -> Win
            Paper -> Draw
            Scissors -> Loss
        Scissors -> case m1 of
            Rock -> Loss
            Paper -> Win
            Scissors -> Draw

score :: (Move,Move) -> Int
score m@(_,m2) =
    let
        res = result m
        resScore = case res of
            Win -> 6
            Draw -> 3
            Loss -> 0
        moveScore = case m2 of
            Rock -> 1
            Paper -> 2
            Scissors -> 3
    in
        resScore + moveScore