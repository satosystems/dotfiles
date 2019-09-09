#!/usr/bin/env runhaskell

{-# LANGUAGE OverloadedStrings #-}

module Main where

import           Data.List                      ( elemIndex
                                                , foldl'
                                                )
import           Data.Maybe                     ( isJust )
import           Data.Text                     as T
                                                ( pack
                                                , splitOn
                                                , unpack
                                                )
import           GHC.IO.Handle                  ( hGetContents )
import           System.Process                 ( CreateProcess(std_out)
                                                , StdStream(CreatePipe)
                                                , createProcess
                                                , proc
                                                , system
                                                )

findCurrentBranch :: [String] -> String
findCurrentBranch (branch : branches) = go branch
 where
  go ('*' : ' ' : '(' : cs) = ""
  go ('*'       : ' ' : cs) = cs
  go _                      = findCurrentBranch branches

filterConflicted :: String -> Bool
filterConflicted ('|' : cs) =
  isJust (elemIndex '(' cs) && isJust (elemIndex ')' cs)
filterConflicted _ = False

extractBranches :: String -> [String]
extractBranches line =
  let Just start = elemIndex '(' line
      Just end   = elemIndex ')' line
      start'     = succ start
      branches = splitOn ", " $ pack . take (end - start') . drop start' $ line
  in  map unpack branches

extractComment :: String -> String
extractComment line =
  let Just start = elemIndex ')' line in drop (start + 2) line

findRebasedCommit :: String -> [String] -> Maybe String
findRebasedCommit _ [] = Nothing
findRebasedCommit keyword (line : graph)
  | take 2 line == "* " = go (take 7 . drop 2 $ line) keyword False
  $ drop 10 line
  | otherwise = findRebasedCommit keyword graph
 where
  go _ _ _ "" = findRebasedCommit keyword graph
  go hash keyword False (' ' : ' ' : '(' : comment) =
    go hash keyword True comment
  go hash keyword True (')' : ' ' : comment) =
    if keyword == comment then Just hash else findRebasedCommit keyword graph
  go hash keyword False (' ' : ' ' : comment) =
    if keyword == comment then Just hash else findRebasedCommit keyword graph
  go hash keyword b (_ : cs) = go hash keyword b cs

rebranch :: (String, (String, [String])) -> IO ()
rebranch (hash, (comment, branches)) = mapM_
  (\branch -> do
    system $ "git branch -D " ++ branch
    system $ "git checkout " ++ hash
    system $ "git branch " ++ branch
  )
  branches

folder
  :: [String]
  -> [(String, (String, a))]
  -> (String, a)
  -> [(String, (String, a))]
folder graph acc pair@(comment, _) = case findRebasedCommit comment graph of
  Nothing   -> acc
  Just hash -> (hash, pair) : acc

command :: String -> [String] -> IO String
command exe args = do
  (_, Just hOut, _, _) <- createProcess (proc exe args) { std_out = CreatePipe }
  hGetContents hOut

main :: IO ()
main = do
  contents <- getContents
  let graph      = lines contents
  let conflicted = filter filterConflicted graph
  let branches   = map extractBranches conflicted
  let comments   = map extractComment conflicted
  let pairs      = zip comments branches
  let trios      = foldl' (folder graph) [] pairs
  gitBranchResult <- command "git" ["branch"]
  let currentBranch = findCurrentBranch $ lines gitBranchResult
  currentHash <- command "git" ["rev-parse", "HEAD"]
  mapM_ rebranch trios
  if null currentBranch
    then system $ "git checkout " ++ currentHash
    else system $ "git checkout " ++ currentBranch
  return ()
