module AoC.Year2022.Day7 ( day7, scratch ) where

import AoC.Prelude ( Problem(..), dummy )
import Data.Char ( isDigit )
import Data.List ( nub )

data Line = CD String | LS | DirInfo String | FileInfo String Int | Invalid
    deriving (Eq,Show)

size :: Line -> Int
size (FileInfo _ s) = s
size _ = 0

parseCmd :: String -> Line
parseCmd [] = Invalid
parseCmd str = case head str of
    'l' -> LS
    'c' -> CD $ drop 3 str
    _   -> Invalid

parseLine :: String -> Line
parseLine [] = Invalid
parseLine str = case head str of
    '$' -> parseCmd $ drop 2 str
    'd' -> DirInfo $ drop 4 str
    _   -> let (num,rest) = span isDigit str in FileInfo (tail rest) (read num)

day7 :: Problem
day7 = Problem 2022 7 (show . sum . map size . nub . map parseLine . lines) dummy

scratch :: IO ()
scratch = readFile "inputs/2022/day7.txt" >>= print . map parseLine . lines