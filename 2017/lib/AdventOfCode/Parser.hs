module AdventOfCode.Parser where

import qualified Data.Attoparsec.ByteString.Char8 as A
import qualified Data.ByteString                  as B

import AdventOfCode.Helpers ((.:))

parsed = either error id .: A.parseOnly

tillSpace :: A.Parser B.ByteString
tillSpace = A.takeWhile (/=' ')
