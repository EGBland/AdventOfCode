module AoC.Structures.Digraph (Digraph, empty, addArc, lookup, nodeCount, adjacencyMatrix) where

import Prelude hiding ( lookup )
import qualified Data.Map.Strict as M
import Data.Matrix ( Matrix, matrix )
import Data.Maybe ( isJust )

data Digraph a = Digraph [a] (M.Map (a,a) Int)
    deriving (Show)

empty :: Digraph a
empty = Digraph [] M.empty

addArc :: (Eq a, Ord a) => Digraph a -> a -> a -> Int -> Digraph a
addArc (Digraph nodes arcs) x y w =
    let
        nodes2 = if elem y nodes then nodes else y:nodes
        nodes3 = if elem x nodes2 then nodes2 else x:nodes2
    in
        Digraph nodes3 (M.insert (x,y) w arcs)

lookup :: (Ord a) => Digraph a -> (a,a) -> Maybe Int
lookup (Digraph _ arcs) = flip M.lookup arcs

nodeCount :: Digraph a -> Int
nodeCount (Digraph nodes _) = length nodes

adjacencyMatrix :: (Ord a) => Digraph a -> Matrix Bool
adjacencyMatrix g = let n = nodeCount g in matrix n n (isAdjacentEnum g)

isAdjacentEnum :: (Ord a) => Digraph a -> (Int,Int) -> Bool
isAdjacentEnum g@(Digraph nodes _) (x,y) =
    let enum = enumerate nodes
    in isJust $ do
        a <- M.lookup x enum
        b <- M.lookup y enum
        lookup g (a,b)

enumerate :: [a] -> M.Map Int a
enumerate = M.fromList . zip [1..]