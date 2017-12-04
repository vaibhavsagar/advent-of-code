parseInput : String -> List (List (List Char))
parseInput str = map (map unpack . words) $ lines str

part1 : List (List (List Char)) -> Nat
part1 input = length . filter (\ls => ls == nub ls) $ input

part2 : List (List (List Char)) -> Nat
part2 input = length . filter (\ls => ls == nub ls) $ map (map sort) input

main : IO ()
main = do
  (Right input) <- readFile "../input/day4.txt"
  let parsed = parseInput input
  printLn $ part1 parsed
  printLn $ part2 parsed
