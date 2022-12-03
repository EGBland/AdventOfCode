module Main where

import AoC.Prelude ( Problem(..), solveProblem )
import AoC.Year2022.Days ( days )
import Text.Printf ( printf )

printProblem :: Problem -> IO ()
printProblem p@(Problem year day _ _) = do
    (p1,p2) <- solveProblem p
    printf "%d\t%d\t%d\t%d\n" year day p1 p2

main :: IO ()
main = sequence_ $ map printProblem days
--main = readFile "inputs/2022/day3.txt" >>= print . map (uncurry firstInCommon . halve) . lines
