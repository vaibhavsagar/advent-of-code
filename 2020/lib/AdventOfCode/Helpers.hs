module AdventOfCode.Helpers
    ( (&)
    , (.:)
    , freqs
    , ordNub
    ) where

import           Data.Function ((&))
import           Data.List (foldl')
import qualified Data.Map as Map
import qualified Data.Set as Set

(.:) :: (c -> d) -> (a -> b -> c) -> a -> b -> d
(.:) = (.).(.)

freqs :: Ord a => [a] -> Map.Map a Int
freqs = foldl' (\m a -> Map.insertWith (+) a 1 m) Map.empty

ordNub :: (Ord a) => [a] -> [a]
ordNub = go Set.empty
    where
        go _ [] = []
        go s (x:xs) = if x `Set.member` s
            then go s xs
            else x : go (Set.insert x s) xs
