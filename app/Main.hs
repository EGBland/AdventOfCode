module Main where

import Text.Printf (printf)

import AoCPrelude
import AoC21

dayPrintf :: Int -> String
dayPrintf = printf "data/21/%d.txt"

doDay :: (Problem,String) -> IO ()
doDay (p,d) = do
    putStrLn . show $ doProblem1 p d
    putStrLn . show $ doProblem2 p d

main :: IO ()
main = do
    let days = [1..3] :: [Int]
    daysData <- sequence $ map (readFile . dayPrintf) days
    let probPairs = zip problems21 daysData
    sequence_ $ map doDay probPairs