module Main

compute : List Char -> List Char -> Nat
compute list1 list2 = let
  zipped = zip list1 list2
  filtered = filter (\(a,b) => a == b) zipped
  mapped = map (\p => cast (pack [fst p])) filtered
  in sum mapped

part1 : List Char -> Nat
part1 list = let
  Just h = head' list
  Just t = tail' list
  list2 = (t ++ [h])
  in compute list list2

part2 : List Char -> Nat
part2 list = let
  halfLength = (length list) `div` 2
  half1 = take halfLength list
  half2 = drop halfLength list
  conc  = half2 ++ half1
  in compute list conc

main : IO ()
main = do
  (Right input) <- readFile "../input/day1.txt"
  let (Just stripped) = init' $ unpack input
  printLn $ part1 stripped
  printLn $ part2 stripped
