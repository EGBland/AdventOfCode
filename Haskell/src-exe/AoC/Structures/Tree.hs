module AoC.Structures.Tree ( Tree(..), resolve, resolveBy, addSibling, addChild ) where

import Control.Applicative ( liftA2 )

data Tree a = Tip | Branch (Tree a) a (Tree a)
    deriving (Show)

instance Functor Tree where
    fmap :: (a -> b) -> Tree a -> Tree b
    fmap _ Tip = Tip
    fmap f (Branch left x right) = Branch (fmap f left) (f x) (fmap f right)

instance Applicative Tree where
    pure :: a -> Tree a
    pure x = Branch Tip x Tip
    
    liftA2 :: (a -> b -> c) -> Tree a -> Tree b -> Tree c
    liftA2 _ Tip _ = Tip
    liftA2 _ _ Tip = Tip
    liftA2 f (Branch lx x rx) (Branch ly y ry) = Branch (liftA2 f lx ly) (f x y) (liftA2 f rx ry)

foldTreeLeft :: (Monoid m) => (a -> m) -> Tree a -> m
foldTreeLeft _ Tip = mempty
foldTreeLeft f (Branch l x r) = f x <> foldTreeLeft f l <> foldTreeLeft f r

instance Foldable Tree where
    foldMap :: Monoid m => (a -> m) -> Tree a -> m
    foldMap = foldTreeLeft

instance Traversable Tree where
    traverse :: Applicative f => (a -> f b) -> Tree a -> f (Tree b)
    traverse _ Tip = pure Tip
    traverse f (Branch l x r) = Branch <$> traverse f l <*> f x <*> traverse f r


resolve :: (Eq a) => [a] -> Tree a -> Maybe (Tree a)
resolve = resolveBy (==)

resolveBy :: (a -> b -> Bool) -> [a] -> Tree b -> Maybe (Tree b)
resolveBy _ _ Tip = Nothing
resolveBy _ [] _ = Nothing
resolveBy f [x] b@(Branch l y r) = if f x y then Just b else resolveBy f [x] r
resolveBy f (x:xs) (Branch l y r) = if f x y then resolveBy f xs l else resolveBy f (x:xs) r

addSibling :: a -> Tree a -> Tree a
addSibling _ Tip = Tip
addSibling x (Branch l y Tip) = Branch l y (pure x)
addSibling x (Branch l y r) = Branch l y (addSibling x r)

addChild :: a -> Tree a -> Tree a
addChild _ Tip = Tip
addChild x (Branch Tip y r) = Branch (pure x) y r
addChild x (Branch l y r) = Branch (addSibling x l) y r