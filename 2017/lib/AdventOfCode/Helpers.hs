module AdventOfCode.Helpers
    ( (&)
    , (.:)
    ) where

import Data.Function ((&))

(.:) :: (c -> d) -> (a -> b -> c) -> a -> b -> d
(.:) = (.).(.)

