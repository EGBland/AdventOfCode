module AoC.Year2015.Day4 ( day4 ) where

import AoC.Prelude ( Problem(..), dummy )
import Crypto.Hash.MD5 ( hash )
import Data.ByteString ( ByteString )
import qualified Data.ByteString as BS
import Data.ByteString.Builder ( byteStringHex, toLazyByteString )
import Data.ByteString.Char8 ( pack )
import Data.ByteString.Lazy.Char8 ( unpack )
import Text.Printf ( printf )

firstHash :: Int -> String -> Int
firstHash n input = fst . head . dropWhile (any (/='0') . take n . snd) . zip [1..] . map (unpack . toLazyByteString . byteStringHex . hash . pack) $ [printf "%s%d" input x | x <- [1..] :: [Int]]

day4 :: Problem
day4 = Problem 2015 4 (firstHash 5) (firstHash 6)