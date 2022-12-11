module AoC.Year2022.Day8 ( day8 ) where

import AoC.Prelude ( Problem(..), dummy )
import Data.List ( maximum, maximumBy, singleton )
import Data.Ord ( comparing )
import qualified Data.Map.Strict as M

day8 :: Problem
day8 = Problem 2022 8 solveProblem1 solveProblem2

solveProblem1 :: String -> String
solveProblem1 input =
    let
        grid = coordifyGrid input
    in
        show . length . filter id . map (isVisible grid) . M.keys $ grid

solveProblem2 :: String -> String
solveProblem2 input = let grid = coordifyGrid input in show . maximum . map (scenicScore grid) . M.keys $ grid

scenicScore :: M.Map (Int,Int) Int -> (Int,Int) -> Int
scenicScore grid c@(cx,cy) =
    let
        xMax = maximum . map fst . M.keys $ grid
        yMax = maximum . map snd . M.keys $ grid
        left  = reverse [(x,cy) | x <- [1..cx-1]]
        right = [(x,cy) | x <- [cx+1..xMax]]
        up    = reverse [(cx,y) | y <- [1..cy-1]]
        down  = [(cx,y) | y <- [cy+1..yMax]]
    in
        product . map (length . takeWhile (\x -> M.findWithDefault 0 c grid > M.findWithDefault 0 x grid)) $ [left,right,up,down]

isVisible :: M.Map (Int,Int) Int -> (Int,Int) -> Bool
isVisible grid (cx,cy) =
    let
        xMax = maximum . map fst . M.keys $ grid
        yMax = maximum . map snd . M.keys $ grid
        left  = [(x,cy) | x <- [1..cx-1]]
        right = [(x,cy) | x <- [cx+1..xMax]]
        up    = [(cx,y) | y <- [1..cy-1]]
        down  = [(cx,y) | y <- [cy+1..yMax]]
    in
        any (isClear grid (cx,cy)) [left,right,up,down]

isClear :: M.Map (Int,Int) Int -> (Int,Int) -> [(Int,Int)] -> Bool
isClear grid c = foldr (\x -> (&&) ((M.findWithDefault 0 c grid) > (M.findWithDefault 0 x grid))) True


coordifyGrid :: String -> M.Map (Int,Int) Int
coordifyGrid = M.fromList . concat . map coordify . zip [1..] . map (zip [1..] . (map ((read::String->Int) . singleton))) . lines

coordify :: (Int,[(Int,Int)]) -> [((Int,Int),Int)]
coordify (y,xs) = foldr (\(x,v) acc -> ((x,y),v):acc) [] xs

-- [(Int,[(Int,Int)])]