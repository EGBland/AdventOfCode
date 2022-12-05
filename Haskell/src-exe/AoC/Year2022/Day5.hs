module AoC.Year2022.Day5 ( day5 ) where

import AoC.Prelude ( Problem(..), dummy )
import Data.Char ( isDigit )
import Data.Map.Strict ( Map, (!), insert )
import qualified Data.Map.Strict as M
import Data.Maybe ( mapMaybe )

day5 :: Problem
day5 = Problem 2022 5 solveProblem1 dummy

solveProblem1 :: String -> String
solveProblem1 input =
    let
        (configLines, moveLines) = divvyFile input
        initialState = parseConfig configLines
        moves = map parseMove moveLines

divvyFile :: String -> ([String],[String])
divvyFile input =
    let
        configLines = init . takeWhile (not . null) . lines $ input
        moveLines = drop (length configLines + 2) . lines $ input
    in
        (configLines, moveLines)

parseConfig :: [String] -> Map Int [Char]
parseConfig configLines =
    let
        noStacks = ((length . head $ configLines) + 1) `div` 4
        stackMap = [(n,mapMaybe (readStackSymbol n) configLines) | n <- [1..noStacks]]
    in
        M.fromList stackMap

parseMove :: String -> Map Int [Char] -> Map Int [Char]
parseMove input m =
    let
        nStr = takeWhile isDigit . drop 5 $ input
        nLen = length nStr
        n = read nStr :: Int
        from = read . take 1 . drop (11 + nLen) $ input
        to = read . take 1 . drop (16 + nLen) $ input

        sFromNextState = drop n $ m!from
        sToNextState = (reverse . take n $ m!from) ++ (m!to)
    in
        (insert from sFromNextState) . (insert to sToNextState) $ m


readStackSymbol :: Int -> String -> Maybe Char
readStackSymbol stackNo line = let c = line!!(4*stackNo-3) in if c == ' ' then Nothing else Just c

takeWhileWithLast :: (a -> Bool) -> [a] -> [a]
takeWhileWithLast f xs = let (ys1,ys2) = span f xs in ys1++[head ys2]