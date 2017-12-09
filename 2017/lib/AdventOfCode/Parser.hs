module AdventOfCode.Parser where

import qualified Data.Attoparsec.ByteString as A
import qualified Data.ByteString            as B
import           Data.Char (ord)

import AdventOfCode.Helpers ((.:))

parsed = either error id .: A.parseOnly

tillSpace :: A.Parser B.ByteString
tillSpace = A.takeWhile (/=(fromIntegral $ ord ' '))
