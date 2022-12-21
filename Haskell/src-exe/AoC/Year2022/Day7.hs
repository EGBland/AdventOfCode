module AoC.Year2022.Day7 ( day7 ) where

import AoC.Prelude ( Problem(..), dummy )
import AoC.Structures.Tree (Tree(..), left, addChildTo, resolveBy)
import Data.Char ( isDigit )
import Data.Maybe ( fromMaybe )

day7 :: Problem
day7 = Problem 2022 7 solveProblem1 solveProblem2

solveProblem1 :: String -> String
solveProblem1 input = show . maybe 0 (sum . filter (<=100000)) $ directorySizes =<< parseFileTree input

solveProblem2 :: String -> String
solveProblem2 input = show . fromMaybe 0 $ parseFileTree input >>= \fileTree -> do
    let spaceToFree = (30000000-) . (70000000-) . totalSize $ fileTree
    dirSizes <- directorySizes fileTree
    return . minimum . filter (>=spaceToFree) $ dirSizes

data Line = CD String | LS | DirInfo String | FileInfo String Int | Invalid
    deriving (Eq,Show)

data File = File String Int | Dir String
    deriving (Eq,Show)

name :: File -> String
name (Dir dirname) = dirname
name (File fname _) = fname

size :: File -> Int
size (File _ fs) = fs
size _ = 0

totalSize :: Tree File -> Int
totalSize = foldl (\acc f -> size f + acc) 0 . left

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

directorySizes :: Tree File -> Maybe [Int]
directorySizes tree = mapM (\fpath -> totalSize <$> resolveBy nameResolver fpath tree) $ accDirPaths tree

parseFileTree :: String -> Maybe (Tree File)
parseFileTree = snd . foldl (flip delta) (["/"],Just . pure $ Dir "/") . map parseLine . lines

accDirPaths :: Tree File -> [[String]]
accDirPaths tree = accDirPaths' tree ([],[]) 

accDirPaths' :: Tree File -> ([String],[[String]]) -> [[String]]
accDirPaths' Tip state = snd state
accDirPaths' (Branch child file sibling) (cwd,paths) =
    let
        addThisPath = case file of
            File _ _    -> paths
            Dir dirname -> (cwd++[dirname]):paths
        childcwd = cwd++[name file]
        addChildPaths = accDirPaths' child (childcwd, addThisPath)
        addSiblingPaths = accDirPaths' sibling (cwd, addChildPaths)
    in
        addSiblingPaths

nameResolver :: String -> File -> Bool
nameResolver str f = str == name f

delta :: Line -> ([String],Maybe (Tree File)) -> ([String],Maybe (Tree File))
delta l state@(cwd,ctree) =
    case l of
        CD newdir -> case newdir of
            "/"  -> (["/"], ctree)
            ".." -> (init cwd, ctree)
            _    -> (cwd ++ [newdir], ctree >>= addChildTo nameResolver cwd (Dir newdir))
        FileInfo fn fs -> (cwd, ctree >>= addChildTo nameResolver cwd (File fn fs))
        _         -> state