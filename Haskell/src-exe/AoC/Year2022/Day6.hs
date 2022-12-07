module AoC.Year2022.Day6 ( day6 ) where

import AoC.Prelude ( Problem(..) )

import Data.List ( nub )

day6 :: Problem
day6 = Problem 2022 6 (show . getMarkerPos 4) (show . getMarkerPos 14)

getMarkerPos :: Int -> String -> Int
getMarkerPos n = getMarkerPos' n n

getMarkerPos' :: Int -> Int -> String -> Int
getMarkerPos' n caret str = if allDistinct . take n $ str then caret else getMarkerPos' n (caret+1) (tail str)

allDistinct :: (Eq a) => [a] -> Bool
allDistinct xs = nub xs == xs