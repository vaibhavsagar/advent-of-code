module Main

parseInput : String -> List (List Nat)
parseInput str = map (map cast) $ map words $ lines str

part1 : List (List Nat) -> Nat
part1 xs = sum $ map (\l => foldr maximum 0 l `minus` foldr minimum 1000000 l) xs

evenDivs : List Nat -> List Nat
evenDivs ls = do
  tls <- tails ls
  guard $ tail' tls /= Nothing
  let (x :: xs) = tls
  y <- xs
  let (x',y') = if x > y then (x,y) else (y,x)
  guard $ (x' `mod` y') == 0
  pure (x' `div` y')

part2 : List (List Nat) -> Nat
part2 xs = sum $ concat $ map evenDivs xs

main : IO ()
main = do
  (Right input) <- readFile "../input/day2.txt"
  let parsed = parseInput input
  printLn $ part1 parsed
  printLn $ part2 parsed

