module AoC21 (
    problems21, d3_commonDigit, d3_co2Fold
)
where

import AoCPrelude

---------------------- UTILITY FUNCTIONS -----------------------
step :: [a] -> [(a,a)]
step xs = zip xs (tail xs)

readInt :: String -> Int
readInt = read

step3 :: [a] -> [(a,a,a)]
step3 xs = zip3 xs (tail xs) (tail . tail $ xs)

sum2ple :: (Num a) => (a,a) -> (a,a) -> (a,a)
sum2ple (a,b) (c,d) = (a+c, b+d)

if' :: Bool -> a -> a -> a
if' f x y = if f then x else y


------------------- PROBLEM IMPLEMENTATIONS --------------------
---------------------------- DAY 1 -----------------------------
d1_p1 :: String -> Int
d1_p1 = length . filter (\(x,y) -> y > x) . step . (map readInt) . lines

d1_p2 :: String -> Int
d1_p2 = length . filter (\(x,y) -> y > x) . step . (map $ \(x,y,z) -> x+y+z) . step3 . (map readInt) . lines


---------------------------- DAY 2 -----------------------------
d2_decode :: String -> (Int,Int)
d2_decode ('f':xs) = (read $ drop 7 xs,0)
d2_decode ('d':xs) = (0,read $ drop 4 xs)
d2_decode ('u':xs) = (0,negate . read $ drop 2 xs)

d2_p1 :: String -> Int
d2_p1 =
    let
        fFold :: (Int,Int) -> String -> (Int,Int)
        fFold (x,y) inst = sum2ple (x,y) (d2_decode inst)
    in
        (\(x,y) -> x*y) . foldl fFold (0,0) . lines
    

d2_p2 :: String -> Int
d2_p2 =
    let
        fFold :: (Int,Int,Int) -> String -> (Int,Int,Int)
        fFold (x,y,a) inst = let (m,n) = d2_decode inst in (x+m,y+a*m,a+n)
    in
        (\(x,y,_) -> x*y) . foldl fFold (0,0,0) . lines


---------------------------- DAY 3 -----------------------------
d3_readCode :: String -> [Int]
d3_readCode = map $ read . pure

d3_bin2int :: [Int] -> Int
d3_bin2int = fst . foldr (\x (y,pow) -> (y+x*pow,2*pow)) (0,1)

d3_commonDigit :: [[Int]] -> Int -> Int
d3_commonDigit xs n = if' (2 * (sum $ map (!!n) xs) >= length xs) 1 0

d3_gamma :: [[Int]] -> Int
d3_gamma xs = d3_bin2int $ map (d3_commonDigit xs) [0..(length . head $ xs) - 1]

d3_epsilon :: [[Int]] -> Int
d3_epsilon xs = 2 ^ (length . head $ xs) - 1 - d3_gamma xs

d3_o2Fold :: [[Int]] -> Int -> [[Int]]
d3_o2Fold xs n
    | length xs == 1 = xs
    | otherwise = filter (\y -> y!!n == d3_commonDigit xs n) xs

d3_o2 :: [[Int]] -> Int
d3_o2 xs = d3_bin2int . head $ foldl d3_o2Fold xs [0..(length . head $ xs) - 1]

d3_co2Fold :: [[Int]] -> Int -> [[Int]]
d3_co2Fold xs n
    | length xs == 1 = xs
    | otherwise = filter (\y -> y!!n == 1-(d3_commonDigit xs n)) xs

d3_co2 :: [[Int]] -> Int
d3_co2 xs = d3_bin2int . head $ foldl (d3_co2Fold) xs [0..(length . head $ xs) - 1]

d3_p1 :: String -> Int
d3_p1 x =
    let
        codes = map d3_readCode . lines $ x
    in
        (d3_gamma codes) * (d3_epsilon codes)

d3_p2 :: String -> Int
d3_p2 x =
    let
        codes = map d3_readCode . lines $ x
    in
        (d3_o2 codes) * (d3_co2 codes)


----------------------- MODULE FUNCTIONS -----------------------
day1 :: Problem
day1 = Problem d1_p1 d1_p2

day2 :: Problem
day2 = Problem d2_p1 d2_p2

day3 :: Problem
day3 = Problem d3_p1 d3_p2

problems21 :: [Problem]
problems21 = [day1,day2,day3]