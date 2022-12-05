module AoC.Year2022.Day5 ( day5 ) where

import AoC.Prelude ( Problem(..), dummy )
import Data.Map.Strict ( Map )
import qualified Data.Map.Strict as M
import Data.Maybe ( mapMaybe )

day5 :: Problem
day5 = Problem 2022 5 solveProblem1 dummy

solveProblem1 :: String -> String
solveProblem1 = show . parseConfig

parseConfig :: String -> Map Int [Char]
parseConfig input =
    let
        configLines = takeWhile (not . null) . lines $ input
        noStacks = (length . head $ configLines) * 4 - 1
        stackMap = [(n,mapMaybe (readStackSymbol n) configLines) | n <- [1..noStacks]]
    in
        M.fromList stackMap

readStackSymbol :: Int -> String -> Maybe Char
readStackSymbol stackNo line = let c = line!!(4*stackNo-3) in if c == ' ' then Nothing else Just c

takeWhileWithLast :: (a -> Bool) -> [a] -> [a]
takeWhileWithLast f xs = let (ys1,ys2) = span f xs in ys1++[head ys2]