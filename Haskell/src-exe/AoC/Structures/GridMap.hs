module AoC.Structures.GridMap ( coordifyGrid ) where

import Data.List ( singleton )
import qualified Data.Map.Strict as M

coordifyGrid :: String -> M.Map (Int,Int) Int
coordifyGrid = M.fromList . concat . map coordify . zip [1..] . map (zip [1..] . (map ((read::String->Int) . singleton))) . lines

coordify :: (Int,[(Int,Int)]) -> [((Int,Int),Int)]
coordify (y,xs) = foldr (\(x,v) acc -> ((x,y),v):acc) [] xs