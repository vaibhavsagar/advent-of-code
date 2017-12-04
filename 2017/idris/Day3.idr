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

part2 : Nat -> Nat
part2 x = ?part2_rhs

main : IO ()
main = do
  (Right input) <- readFile "../input/day3.txt"
  let parsed = parseInput input
  printLn $ part1 parsed
  -- printLn $ part2 parsed
