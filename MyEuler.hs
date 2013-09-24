module Main where
import Control.Monad
import Data.List
import Debug.Trace
import System.Environment (getArgs)
import System.Exit
--import Language.Haskell.Interpreter (setImports, eval, runInterpreter, Interpreter, InterpreterError)
--   let eulerFunc = "euler" ++ eulerN
--   --return eulerFunc
-- --eulerEval eulerFunc = fromMaybe (return ()) 


stringToInt :: String -> Int
stringToInt = read

traceShow' arg = traceShow arg arg

help = putStrLn "euler [num] for example euler 1 for the first function!" >> exitWith ExitSuccess

euler []     = help
euler ["-h"] = help

-- ========================================================================
euler ["1"] = print $ sumMultiples 3 + sumMultiples 5 - sumMultiples (3*5)
  where
    sumMultiples x = traceShow' $ sum [x,x*2..end-1]
    --sumMultiples x = sum [x,x*2..end-1]
    end = 1000

euler ["2"]  = print . sum . filter even . takeWhile (<= 4000000) $ fib
  where
    fib = seq 0 1 where seq x y = x+y:seq y (x+y)

--euler ["3"] = print $ 

euler ["fib"] = print (fib 25)
  where
    fib 0 = 0
    fib 1 = 1
    fib n = traceShow' $ fib (n-1) + fib (n-2)
    --fib n = fib (n-1) + fib (n-2)

euler ["fak"] = print (fak 12)
  where
    fak 0 = 1
    fak n = traceShow' $ n * fak (n-1)
    --fak n = n * fak (n-1)


-- ========================================================================
main = do 
  eulerN <- getArgs
  euler eulerN
