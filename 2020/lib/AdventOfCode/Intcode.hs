module AdventOfCode.Intcode where

import qualified Data.Vector as V
import qualified Data.IntMap.Strict as I

data Mode = Position | Immediate | Relative deriving (Eq, Show, Enum)

data Opcode = Opcode
    { opcodeCode  :: Int
    , opcodeMode1 :: Mode
    , opcodeMode2 :: Mode
    , opcodeMode3 :: Mode
    } deriving (Eq, Show)

data ProgramState = ProgramState
    { programStateProgram      :: V.Vector Int
    , programStateMemory       :: I.IntMap Int
    , programStateRelativeBase :: Int
    } deriving (Eq, Show)

parseCode :: Int -> Opcode
parseCode i = let
    m3   = i `div` 10000
    m2   = (i - m3*10000) `div` 1000
    m1   = (i - m3*10000 - m2*1000) `div` 100
    code = i `rem` 100
    in Opcode code (toEnum m1) (toEnum m2) (toEnum m3)

access :: ProgramState -> Int -> Int
access (ProgramState program memory _) index = if index >= V.length program
    then I.findWithDefault 0 index memory
    else program V.! index

update :: ProgramState -> Int -> Int -> ProgramState
update ps@(ProgramState program memory _) index value = if index >= V.length program
    then ps{ programStateMemory = I.insert index value memory }
    else ps{ programStateProgram = program V.// [(index,value)] }

address :: Mode -> ProgramState -> Int -> Int
address mode  programState index = access programState (computeIndex mode programState index)

computeIndex :: Mode -> ProgramState -> Int -> Int
computeIndex Position  programState index = programState `access` index
computeIndex Immediate programState index = index
computeIndex Relative  programState index = (programState `access` index) + programStateRelativeBase programState

step :: ProgramState -> [Int] -> [Int] -> Int -> (ProgramState, [Int], [Int], Int)
step programState input output index = do
    let opcode = parseCode (programState `access` index)
        aIndex = computeIndex (opcodeMode1 opcode) programState (index+1)
        a = address (opcodeMode1 opcode) programState (index+1)
        b = address (opcodeMode2 opcode) programState (index+2)
        o = computeIndex (opcodeMode3 opcode) programState (index+3)
    case opcodeCode opcode of
        1 -> let
            p = update programState o (a+b)
            in (p, input, output, index+4)
        2 -> let
            p = update programState o (a*b)
            in (p, input, output, index+4)
        3 -> let
            (v:input') = input
            p = update programState aIndex v
            in (p, input', output, index+2)
        4 -> let
            output' = output ++ [a]
            in (programState, input, output', index+2)
        5 -> if a/=0
            then (programState, input, output, b)
            else (programState, input, output, index+3)
        6 -> if a==0
            then (programState, input, output, b)
            else (programState, input, output, index+3)
        7 -> if a < b
            then (update programState o 1, input, output, index+4)
            else (update programState o 0, input, output, index+4)
        8 -> if a == b
            then (update programState o 1, input, output, index+4)
            else (update programState o 0, input, output, index+4)
        9 -> let
            relativeBase' = programStateRelativeBase programState + a
            p = programState { programStateRelativeBase = relativeBase' }
            in (p, input, output, index+2)
        99 -> (programState, input, output, index)

loop program input output index = let
    (program', input', output', index') = step program input output index
    in if index == index'
        then (program', output', index')
        else loop program' input' output' index'

parse s = read ("[" ++ s ++ "]") :: [Int]

new program = ProgramState (V.fromList program) I.empty 0
