{-# LANGUAGE OverloadedStrings #-}

module AdventOfCode.Input where

import qualified Data.ByteString                  as B
import qualified Data.ByteString.Char8            as B (lines)
import qualified Data.ByteString.UTF8             as BU
import qualified Data.Attoparsec.ByteString       as A
import qualified Data.Attoparsec.ByteString.Char8 as AC

day :: Int -> IO B.ByteString
day n = B.init <$> B.readFile ("../input/day" ++ show n ++ ".txt")

dayString :: Int -> IO String
dayString = fmap BU.toString . day

dayLines :: Int -> IO [B.ByteString]
dayLines = fmap B.lines . day

dayLinesString :: Int -> IO [String]
dayLinesString = fmap (map BU.toString) . dayLines
