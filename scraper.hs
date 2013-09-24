module Main where
import Network.HTTP
import System.Environment

main = do
  args <- getArgs
  html <- simpleHTTP (getRequest "http://localhost")
  --putStrLn $ show args
  putStrLn $ show html
  return ()