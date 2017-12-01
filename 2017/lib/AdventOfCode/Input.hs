{-# LANGUAGE OverloadedStrings #-}

module AdventOfCode.Input where

import qualified Data.ByteString                  as B
import qualified Data.ByteString.Char8            as B (lines)
import qualified Data.Attoparsec.ByteString       as A
import qualified Data.Attoparsec.ByteString.Char8 as AC

day :: Int -> IO [B.ByteString]
day n = B.lines <$> B.readFile ("../input/day" ++ show n ++ ".txt")
