import Data.SortedMap

parseInput : String -> Nat
parseInput s = cast s

genDRDiagonal : Nat -> Int
genDRDiagonal n = (\x => x * x) . head $ drop n [1,3..]

genDRDiagonalSqrt : Nat -> Int
genDRDiagonalSqrt n = head $ drop n [1,3..]

genURDiagonal : Nat -> Int
genURDiagonal n = let
  drDiagonal = genDRDiagonal n
  s = genDRDiagonalSqrt n
  in drDiagonal - ((s-1)*3)

genULDiagonal : Nat -> Int
genULDiagonal n = let
  drDiagonal = genDRDiagonal n
  s = genDRDiagonalSqrt n
  in drDiagonal - ((s-1)*2)

genDLDiagonal : Nat -> Int
genDLDiagonal n = let
  drDiagonal = genDRDiagonal n
  s = genDRDiagonalSqrt n
  in drDiagonal - (s-1)

getPos : Nat -> (Int, Int)
getPos n = if n' == dr
           then (pos', -pos')
           else if n' < dr && n' >= dl
           then (-pos' + (n' - dl), -pos')
           else if n' < dl && n' >= ul
           then (-pos', pos' - (n' - ul))
           else if n' < ul && n' >= ur
           then (pos' - (n' - ur), pos')
           else (pos', pos' - (ur - n'))
  where
    diagonals : List Nat
    diagonals = takeWhile (<n) $ take 1000 $ map (flip power 2) [1,3..]
    pos : Nat
    pos = length diagonals
    dr : Int
    dr = genDRDiagonal pos
    dl : Int
    dl = genDLDiagonal pos
    ur : Int
    ur = genURDiagonal pos
    ul : Int
    ul = genULDiagonal pos
    pos' : Int
    pos' = cast pos
    n' : Int
    n' = cast n

part1 : Nat -> Int
part1 x = let
  (x,y) = getPos x
  in (abs x) + (abs y)

neighbours : (Int, Int) -> List (Int, Int)
neighbours (x, y) =
  [ (x-1, y-1), (x, y-1), (x+1, y-1)
  , (x-1, y),             (x+1, y)
  , (x-1, y+1), (x, y+1), (x+1, y+1)
  ]


sumNeighbours : SortedMap (Int, Int) Nat -> (Int, Int) -> Nat
sumNeighbours g c = sum $ map (\c' => fromMaybe 0 (lookup c' g)) $ neighbours c

loop : SortedMap (Int, Int) Nat -> Nat -> Nat -> Nat
loop gr i stop = let
    coord = getPos i
    value = sumNeighbours gr coord
    in if value > stop
        then value
        else loop (insert coord value gr) (i+1) stop

part2 : Nat -> Nat
part2 x = loop (fromList [((0,0), 1)]) 2 x

main : IO ()
main = do
  (Right input) <- readFile "../input/day3.txt"
  let parsed = parseInput input
  printLn $ part1 parsed
  printLn $ part2 parsed
