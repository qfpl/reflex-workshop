module Main where

import qualified GHC.IO.Encoding as E

import Control.Monad (when, forM_)
import Data.List (isPrefixOf)

import System.Environment

import Data.Text (Text)
import qualified Data.Text as Text

import System.FilePath
import System.Directory
import Text.Pandoc
import Text.Pandoc.Highlighting (pygments)

data Dirs = Dirs { inputDir :: FilePath, outputDir :: FilePath }

main :: IO ()
main = do
  E.setLocaleEncoding E.utf8
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
  et <- runIO . mdToHtml . Text.pack $ sIn
  case et of
    Left e -> print e
    Right t -> writeFile (to </> takeBaseName fp <.> "html") (Text.unpack t)

mdToHtml :: PandocMonad m => Text -> m Text
mdToHtml md = do
  x <- readMarkdown (def { readerExtensions = pandocExtensions }) md
  writeHtml5String (def { writerHighlightStyle = Just pygments}) x

processMdsFile :: Dirs -> FilePath -> IO ()
processMdsFile (Dirs from to) fp = do
  sIn <- readFile $ from </> fp
  let base = to </> takeBaseName fp </> "solution"
  createDirectoryIfMissing True base
  ets <- runIO $ mdsToHtml . Text.pack $ sIn
  case ets of
    Left e -> print e
    Right ts -> do
      let sOut = zip [0..] . fmap Text.unpack $ ts
      forM_ sOut $ \(i, s) ->
        writeFile (base </> show i <.> "html") s

separator :: Text -> Bool
separator = Text.isPrefixOf (Text.pack "===")

separate :: [Text] -> (Text, [Text])
separate s =
  let
    (a, b) = break separator s
    (_, c) = span  separator b
  in
    (Text.unlines a, c)

gatherSingle :: [Text] -> [Text]
gatherSingle [] = []
gatherSingle ss =
  let
    (a, b) = separate ss
  in
    a : gatherSingle b

mdsToHtml :: PandocMonad m => Text -> m [Text]
mdsToHtml =
  traverse mdToHtml .
  gatherSingle .
  Text.lines
