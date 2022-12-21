module Main where

import AoC.Prelude ( Problem(..), solveProblem )
import AoC.Year2022.Days ( days )
import Control.Monad ( join )
import Text.Printf ( printf )

import AoC.Structures.Digraph ( Digraph, empty, addArc, adjacencyMatrix )
import AoC.Structures.Tree ( Tree(..), addSibling, addChild, addSiblingTo, addChildTo )
import Data.Matrix ( prettyMatrix )

printProblem :: Problem -> IO ()
printProblem p@(Problem year day _ _) = do
    ((t1,p1),(t2,p2)) <- solveProblem p
    printf "%d\t%d\t%s\t(%.3fs)\t%s\t(%.3fs)\n" year day p1 t1 p2 t2

main :: IO ()
main = mapM_ printProblem days >> do
    let root = addSibling "sib2" . addSibling "sib1" . pure $ "root" :: Tree String
    let root2 = addChildTo (==) ["sib2"] "child1" root
    let root3 = root2 >>= addChildTo (==) ["sib2","child1"] "child2"
    let root4 = root3 >>= addSiblingTo (==) ["sib2"] "kidsib"

    print root4