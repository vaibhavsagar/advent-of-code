{-# LANGUAGE RankNTypes #-}

module AdventOfCode.Vector.Unboxed where

import           Control.Monad.ST (ST, runST)
import qualified Data.Vector.Unboxed as V
import qualified Data.Vector.Unboxed.Mutable as M

withThawed :: (V.Unbox a) => V.Vector a -> (forall s. M.STVector s a -> ST s ()) -> V.Vector a
withThawed vector f = runST $ do
    mut <- V.thaw vector
    f mut
    V.freeze mut
