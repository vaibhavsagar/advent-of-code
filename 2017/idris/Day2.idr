module Main

parseInput : String -> List (List Int)
parseInput str = map ((map cast) . words) $ lines str

part1 : List (List Int) -> Int
part1 xs = sum $ map (\l => foldr max 0 l - foldr min 1000000 l) xs

evenDivs : List Int -> List Int
evenDivs ls =
  [ x' `div` y'
  | (x :: xs) <- filter isCons $ tails ls
  , y <- xs
  , let (x',y') = if x > y then (x,y) else (y,x)
  , (x' `mod` y') == 0
  ]

part2 : List (List Int) -> Int
part2 = sum . concatMap evenDivs

main : IO ()
main = do
  (Right input) <- readFile "../input/day2.txt"
  let parsed = parseInput input
  printLn $ part1 parsed
  printLn $ part2 parsed

