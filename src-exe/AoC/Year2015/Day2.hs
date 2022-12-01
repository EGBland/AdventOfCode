module AoC.Year2015.Day2 ( day2 ) where

import AoC.Prelude ( Problem(..) )
import Data.List ( sort )
import Data.List.Split ( splitOn )

parseDimensions :: [String] -> [(Int,Int,Int)]
parseDimensions = map $ (\xs -> (read $ xs!!0, read $ xs!!1, read $ xs!!2)) . splitOn "x"

wrappingPaperNeeded :: (Int,Int,Int) -> Int
wrappingPaperNeeded (x,y,z) = let extra = product $ take 2 . sort $ [x,y,z] in 2 * (x * y + x * z + y * z) + extra

ribbonLengthNeeded :: (Int,Int,Int) -> Int
ribbonLengthNeeded (x,y,z) = (+x*y*z) . sum . map (*2) . take 2 . sort $ [x,y,z]

solveProblem1 :: String -> Int
solveProblem1 = sum . map wrappingPaperNeeded . parseDimensions . lines

solveProblem2 :: String -> Int
solveProblem2 = sum . map ribbonLengthNeeded . parseDimensions . lines

day2 :: Problem
day2 = Problem 2015 2 solveProblem1 solveProblem2