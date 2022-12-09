module AoC.Year2022.Day7 ( day7 ) where

import AoC.Prelude ( Problem(..), dummy )
import AoC.Structures.Tree ( Tree(..), resolve )

data File = File String Int | Dir String

size :: File -> Int
size (File _ s) = s
size _ = 0

totalSize :: Tree File -> Int
totalSize = sum . fmap size

day7 :: Problem
day7 = Problem 2022 7 dummy dummy