module Main where

import Control.Monad (when, forM_)
import Data.List (isPrefixOf)

import System.Environment

import System.FilePath
import System.Directory
import Text.Pandoc

data Dirs = Dirs { inputDir :: FilePath, outputDir :: FilePath }

main :: IO ()
main = do
  a <- getArgs
  case a of
    [f, t] -> processDir (Dirs f t)
    _ -> putStrLn "Usage: processor [from] [to]"

processDir :: Dirs -> IO ()
processDir d@(Dirs from to) = do
  createDirectoryIfMissing True to
  files <- listDirectory from
  forM_ files $ \f -> do
    let
      pathFrom = from </> f
      pathTo = to </> f
    isFile <- doesFileExist pathFrom
    when isFile $
      processFile d f
    isDir <- doesDirectoryExist pathFrom
    when isDir $
      processDir $ Dirs pathFrom pathTo

processFile :: Dirs -> FilePath -> IO ()
processFile d@(Dirs from to) f =
  case takeExtension f of
    ".md" -> processMdFile d f
    ".mds" -> processMdsFile d f
    _ -> copyFile (from </> f) (to </> f)

processMdFile :: Dirs -> FilePath -> IO ()
processMdFile (Dirs from to) fp = do
  sIn <- readFile $ from </> fp
  writeFile (to </> takeBaseName fp <.> "html") (mdToHtml sIn)

mdToHtml :: String -> String
mdToHtml md =
  case readMarkdown def md of
    Left e -> show e
    Right x -> writeHtmlString (def { writerHighlight = True}) x

processMdsFile :: Dirs -> FilePath -> IO ()
processMdsFile (Dirs from to) fp = do
  sIn <- readFile $ from </> fp
  let base = to </> takeBaseName fp </> "solution"
  createDirectoryIfMissing True base
  let sOut = zip [0..] . mdsToHtml $ sIn
  forM_ sOut $ \(i, s) ->
    writeFile (base </> show i <.> "html") s

separator :: String -> Bool
separator = isPrefixOf "==="

separate :: [String] -> (String, [String])
separate s =
  let
    (a, b) = break separator s
    (_, c) = span  separator b
  in
    (unlines a, c)

gatherSingle :: [String] -> [String]
gatherSingle [] = []
gatherSingle ss =
  let
    (a, b) = separate ss
  in
    a : gatherSingle b

mdsToHtml :: String -> [String]
mdsToHtml =
  fmap mdToHtml .
  gatherSingle .
  lines
