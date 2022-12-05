module Main where

import AoC.Prelude ( Problem(..), solveProblem )
import AoC.Year2022.Days ( days )
import Text.Printf ( printf )

printProblem :: Problem -> IO ()
printProblem p@(Problem year day _ _) = do
    ((t1,p1),(t2,p2)) <- solveProblem p
    printf "%d\t%d\t%s\t(%.3fs)\t%s\t(%.3fs)\n" year day p1 t1 p2 t2

main :: IO ()
main = mapM_ printProblem days
--main = readFile "inputs/2022/day5.txt" >>= print . map length . takeWhile (not . null) . lines
--main = readInterval "1-2,3-4"
--main = print $ sum . tail . takeWhile (>=0) $ iterate (\x -> x`div`3-2) $ (1969::Int)
--main = readFile "inputs/2022/day3.txt" >>= print . map (uncurry firstInCommon . halve) . lines

--main = print . fst . head . dropWhile (not . (=="00000") . take 5 . snd) . zip [1..] . map (unpack . toLazyByteString . byteStringHex . hash . pack) $ [printf "%s%d" "abcdef" x | x <- [1..] :: [Int]]